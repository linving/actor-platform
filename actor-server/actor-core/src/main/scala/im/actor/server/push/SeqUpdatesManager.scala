package im.actor.server.push

import java.nio.ByteBuffer

import im.actor.server.commons.serialization.ActorSerializer

import scala.annotation.tailrec
import scala.concurrent._
import scala.concurrent.duration._

import akka.actor._
import akka.pattern.ask
import akka.util.Timeout
import slick.dbio.DBIO

import im.actor.api.rpc.messaging.UpdateMessage
import im.actor.api.rpc.peers.{ PeerType, Peer }
import im.actor.api.{ rpc ⇒ api }
import im.actor.server.db.DbExtension
import im.actor.server.models.sequence
import im.actor.server.sequence.{ SeqStateDate, SeqState }
import im.actor.server.user.{ UserOffice, UserViewRegion }
import im.actor.server.{ models, persist ⇒ p }

object SeqUpdatesManager {

  import SeqUpdatesManagerMessages._

  type Sequence = Int
  type UpdateRefs = (Set[Int], Set[Int])

  private val log = org.slf4j.LoggerFactory.getLogger(this.getClass)

  // TODO: configurable
  private implicit val OperationTimeout = Timeout(30.seconds)

  def register(): Unit = {
    ActorSerializer.register(60001, classOf[SeqState])
    ActorSerializer.register(60002, classOf[SeqStateDate])
  }

  def getSeqState(authId: Long)(implicit ext: SeqUpdatesExtension, ec: ExecutionContext): Future[SeqState] =
    ext.region.ref.ask(Envelope(authId, GetSequenceState))(OperationTimeout).mapTo[SeqState]

  def persistAndPushUpdate(
    authId:         Long,
    header:         Int,
    serializedData: Array[Byte],
    refs:           UpdateRefs,
    pushText:       Option[String],
    originPeer:     Option[Peer],
    fatMetaData:    Option[FatMetaData]
  )(implicit
    ext: SeqUpdatesExtension,
    ec: ExecutionContext): DBIO[SeqState] = {
    fatMetaData map (ext.getFatData(authId, _) map (Some(_))) getOrElse (DBIO.successful(None)) flatMap { fd ⇒
      DBIO.from(pushUpdateGetSeqState(authId, header, serializedData, refs, pushText, originPeer, fd))
    }
  }

  def persistAndPushUpdate(
    authId:   Long,
    update:   api.Update,
    pushText: Option[String],
    isFat:    Boolean
  )(
    implicit
    ec:  ExecutionContext,
    ext: SeqUpdatesExtension
  ): DBIO[SeqState] = {
    val header = update.header
    val serializedData = update.toByteArray

    val fatMetaData = if (isFat) Some(getFatMetaData(update)) else None
    persistAndPushUpdate(authId, header, serializedData, updateRefs(update), pushText, getOriginPeer(update), fatMetaData)
  }

  def persistAndPushUpdateF(
    authId:         Long,
    header:         Int,
    serializedData: Array[Byte],
    refs:           UpdateRefs,
    pushText:       Option[String],
    originPeer:     Option[Peer],
    fatMetaData:    Option[FatMetaData]
  )(implicit
    ext: SeqUpdatesExtension,
    ec: ExecutionContext): Future[SeqState] = {
    fatMetaData map (ext.getFatDataF(authId, _) map (Some(_))) getOrElse (Future.successful(None)) flatMap { fd ⇒
      pushUpdateGetSeqState(authId, header, serializedData, refs, pushText, originPeer, fd)
    }
  }

  def persistAndPushUpdateF(
    authId:   Long,
    update:   api.Update,
    pushText: Option[String],
    isFat:    Boolean
  )(
    implicit
    ec:  ExecutionContext,
    ext: SeqUpdatesExtension
  ): Future[SeqState] = {
    val header = update.header
    val serializedData = update.toByteArray

    val fatMetaData = if (isFat) Some(getFatMetaData(update)) else None
    persistAndPushUpdateF(authId, header, serializedData, updateRefs(update), pushText, getOriginPeer(update), fatMetaData)
  }

  def persistAndPushUpdates(
    authIds:  Set[Long],
    update:   api.Update,
    pushText: Option[String],
    isFat:    Boolean
  )(implicit
    ec: ExecutionContext,
    ext: SeqUpdatesExtension): DBIO[Seq[SeqState]] = {
    val header = update.header
    val serializedData = update.toByteArray

    val fatMetaData = if (isFat) Some(getFatMetaData(update)) else None

    persistAndPushUpdates(authIds, header, serializedData, updateRefs(update), pushText, getOriginPeer(update), fatMetaData)
  }

  def persistAndPushUpdatesF(
    authIds:  Set[Long],
    update:   api.Update,
    pushText: Option[String],
    isFat:    Boolean
  )(implicit
    ec: ExecutionContext,
    ext: SeqUpdatesExtension): Future[Seq[SeqState]] = {
    val header = update.header
    val serializedData = update.toByteArray

    val fatMetaData = if (isFat) Some(getFatMetaData(update)) else None

    persistAndPushUpdatesF(authIds, header, serializedData, updateRefs(update), pushText, getOriginPeer(update), fatMetaData)
  }

  def persistAndPushUpdates(
    authIds:        Set[Long],
    header:         Int,
    serializedData: Array[Byte],
    refs:           UpdateRefs,
    pushText:       Option[String],
    originPeer:     Option[Peer],
    fatMetaData:    Option[FatMetaData]
  )(implicit
    ec: ExecutionContext,
    ext: SeqUpdatesExtension): DBIO[Seq[SeqState]] =
    DBIO.sequence(authIds.toSeq map { authId ⇒
      persistAndPushUpdate(authId, header, serializedData, refs, pushText, originPeer, fatMetaData)
    })

  def persistAndPushUpdatesF(
    authIds:        Set[Long],
    header:         Int,
    serializedData: Array[Byte],
    refs:           UpdateRefs,
    pushText:       Option[String],
    originPeer:     Option[Peer],
    fatMetaData:    Option[FatMetaData]
  )(implicit
    ec: ExecutionContext,
    ext: SeqUpdatesExtension): Future[Seq[SeqState]] =
    Future.sequence(authIds.toSeq map { authId ⇒
      persistAndPushUpdateF(authId, header, serializedData, refs, pushText, originPeer, fatMetaData)
    })

  def broadcastClientAndUsersUpdate(
    userIds:  Set[Int],
    update:   api.Update,
    pushText: Option[String],
    isFat:    Boolean
  )(implicit
    ec: ExecutionContext,
    ext:    SeqUpdatesExtension,
    client: api.AuthorizedClientData): DBIO[(SeqState, Seq[SeqState])] =
    broadcastClientAndUsersUpdate(client.userId, client.authId, userIds, update, pushText, isFat)

  def broadcastClientAndUsersUpdate(
    clientUserId: Int,
    clientAuthId: Long,
    userIds:      Set[Int],
    update:       api.Update,
    pushText:     Option[String],
    isFat:        Boolean
  )(implicit
    ec: ExecutionContext,
    ext: SeqUpdatesExtension): DBIO[(SeqState, Seq[SeqState])] = {
    val header = update.header
    val serializedData = update.toByteArray

    val originPeer = getOriginPeer(update)
    val fatMetaData = if (isFat) Some(getFatMetaData(update)) else None
    val refs = updateRefs(update)

    for {
      authIds ← p.AuthId.findIdByUserIds(userIds + clientUserId)
      seqstates ← DBIO.sequence(
        authIds.view
          .filterNot(_ == clientAuthId)
          .map(persistAndPushUpdate(_, header, serializedData, refs, pushText, originPeer, fatMetaData))
      )
      seqstate ← persistAndPushUpdate(clientAuthId, header, serializedData, refs, pushText, originPeer, fatMetaData)
    } yield (seqstate, seqstates)
  }

  def broadcastOtherDevicesUpdate(
    userId:        Int,
    currentAuthId: Long,
    update:        api.Update,
    pushText:      Option[String],
    isFat:         Boolean
  )(
    implicit
    ec:  ExecutionContext,
    ext: SeqUpdatesExtension
  ): DBIO[SeqState] = {
    val header = update.header
    val serializedData = update.toByteArray

    val originPeer = getOriginPeer(update)
    val fatMetaData = if (isFat) Some(getFatMetaData(update)) else None
    val refs = updateRefs(update)

    for {
      otherAuthIds ← p.AuthId.findIdByUserId(userId).map(_.view.filter(_ != currentAuthId))
      _ ← DBIO.sequence(otherAuthIds map (authId ⇒ persistAndPushUpdate(authId, header, serializedData, refs, pushText, originPeer, fatMetaData)))
      seqstate ← persistAndPushUpdate(currentAuthId, header, serializedData, refs, pushText, originPeer, fatMetaData)
    } yield seqstate
  }

  def notifyUserUpdate(
    userId:       Int,
    exceptAuthId: Long,
    update:       api.Update,
    pushText:     Option[String],
    isFat:        Boolean
  )(
    implicit
    ec:             ExecutionContext,
    ext:            SeqUpdatesExtension,
    userViewRegion: UserViewRegion
  ): DBIO[Seq[SeqState]] = {
    val header = update.header
    val serializedData = update.toByteArray

    val originPeer = getOriginPeer(update)
    val fatMetaData = if (isFat) Some(SeqUpdatesManager.getFatMetaData(update)) else None

    notifyUserUpdate(userId, exceptAuthId, header, serializedData, updateRefs(update), pushText, originPeer, fatMetaData)
  }

  def notifyUserUpdate(
    userId:         Int,
    exceptAuthId:   Long,
    header:         Int,
    serializedData: Array[Byte],
    refs:           UpdateRefs,
    pushText:       Option[String],
    originPeer:     Option[Peer],
    fatMetaData:    Option[FatMetaData]
  )(implicit
    ec: ExecutionContext,
    ext:            SeqUpdatesExtension,
    userViewRegion: UserViewRegion) = {
    for {
      otherAuthIds ← DBIO.from(UserOffice.getAuthIds(userId)) map (_.filter(_ != exceptAuthId))
      seqstates ← DBIO.sequence(otherAuthIds map { authId ⇒
        persistAndPushUpdate(authId, header, serializedData, refs, pushText, originPeer, fatMetaData)
      })
    } yield seqstates
  }

  def notifyClientUpdate(
    update:   api.Update,
    pushText: Option[String],
    isFat:    Boolean
  )(
    implicit
    ec:             ExecutionContext,
    ext:            SeqUpdatesExtension,
    userViewRegion: UserViewRegion,
    client:         api.AuthorizedClientData
  ): DBIO[Seq[SeqState]] = {
    val header = update.header
    val serializedData = update.toByteArray

    val originPeer = getOriginPeer(update)
    val fatMetaData = if (isFat) Some(getFatMetaData(update)) else None

    notifyClientUpdate(header, serializedData, updateRefs(update), pushText, originPeer, fatMetaData)
  }

  def notifyClientUpdate(
    header:         Int,
    serializedData: Array[Byte],
    refs:           UpdateRefs,
    pushText:       Option[String],
    originPeer:     Option[Peer],
    fatMetaData:    Option[FatMetaData]
  )(implicit
    ec: ExecutionContext,
    ext:            SeqUpdatesExtension,
    userViewRegion: UserViewRegion,
    client:         api.AuthorizedClientData) = {
    notifyUserUpdate(client.userId, client.authId, header, serializedData, refs, pushText, originPeer, fatMetaData)
  }

  def setPushCredentials(
    authId: Long,
    creds:  models.push.PushCredentials
  )(implicit ext: SeqUpdatesExtension): Unit = {
    ext.region.ref ! Envelope(authId, PushCredentialsUpdated(Some(creds)))
  }

  def deletePushCredentials(authId: Long)(implicit ext: SeqUpdatesExtension): Unit = {
    ext.region.ref ! Envelope(authId, PushCredentialsUpdated(None))
  }

  def deleteApplePushToken(token: Array[Byte])(implicit ec: ExecutionContext, system: ActorSystem): Unit = {
    val seqRegion = SeqUpdatesExtension(system).region

    DbExtension(system).db.run(p.push.ApplePushCredentials.findByToken(token)) foreach { creds ⇒
      creds foreach { c ⇒
        seqRegion.ref ! Envelope(c.authId, DeletePushCredentials(Some(c)))
      }
    }
  }

  def getDifference(authId: Long, timestamp: Long, maxSizeInBytes: Long)(implicit ec: ExecutionContext): DBIO[(Vector[models.sequence.SeqUpdate], Boolean)] = {
    def run(state: Long, acc: Vector[models.sequence.SeqUpdate], currentSize: Long): DBIO[(Vector[models.sequence.SeqUpdate], Boolean)] = {
      p.sequence.SeqUpdate.findAfter(authId, state).flatMap { updates ⇒
        if (updates.isEmpty) {
          DBIO.successful(acc → false)
        } else {
          val (newAcc, newSize, allFit) = append(updates.toVector, currentSize, maxSizeInBytes, acc)
          if (allFit) {
            newAcc.lastOption match {
              case Some(u) ⇒ run(u.timestamp, newAcc, newSize)
              case None    ⇒ DBIO.successful(acc → false)
            }
          } else {
            DBIO.successful(newAcc → true)
          }
        }
      }
    }
    run(timestamp, Vector.empty[sequence.SeqUpdate], 0L)
  }

  private def append(updates: Vector[sequence.SeqUpdate], currentSize: Long, maxSizeInBytes: Long, updateAcc: Vector[sequence.SeqUpdate]): (Vector[sequence.SeqUpdate], Long, Boolean) = {
    @tailrec
    def run(updLeft: Vector[sequence.SeqUpdate], acc: Vector[sequence.SeqUpdate], currSize: Long): (Vector[sequence.SeqUpdate], Long, Boolean) = {
      updLeft match {
        case h +: t ⇒
          val newSize = currSize + h.serializedData.length
          if (newSize > maxSizeInBytes && acc.nonEmpty) {
            (acc, currSize, false)
          } else {
            run(t, acc :+ h, newSize)
          }
        case Vector() ⇒ (acc, currSize, true)
      }
    }
    run(updates, updateAcc, currentSize)
  }

  def updateRefs(update: api.Update): (Set[Int], Set[Int]) = {
    def peerRefs(peer: api.peers.Peer): (Set[Int], Set[Int]) = {
      if (peer.`type` == api.peers.PeerType.Private) {
        (Set(peer.id), Set.empty)
      } else {
        (Set.empty, Set(peer.id))
      }
    }

    val empty = (Set.empty[Int], Set.empty[Int])
    def singleUser(userId: Int): (Set[Int], Set[Int]) = (Set(userId), Set.empty)
    def singleGroup(groupId: Int): (Set[Int], Set[Int]) = (Set.empty, Set(groupId))
    def users(userIds: Seq[Int]): (Set[Int], Set[Int]) = (userIds.toSet, Set.empty)

    update match {
      case _: api.misc.UpdateConfig              ⇒ empty
      case _: api.configs.UpdateParameterChanged ⇒ empty
      case api.messaging.UpdateChatClear(peer) ⇒
        peer.`type` match {
          case PeerType.Private ⇒ (Set(peer.id), Set.empty)
          case PeerType.Group   ⇒ (Set.empty, Set(peer.id))
        }
      case api.messaging.UpdateChatDelete(peer) ⇒
        peer.`type` match {
          case PeerType.Private ⇒ (Set(peer.id), Set.empty)
          case PeerType.Group   ⇒ (Set.empty, Set(peer.id))
        }
      case api.messaging.UpdateMessage(peer, senderUserId, _, _, _) ⇒
        val refs = peerRefs(peer)
        refs.copy(_1 = refs._1 + senderUserId)
      case api.messaging.UpdateMessageDelete(peer, _)                              ⇒ peerRefs(peer)
      case api.messaging.UpdateMessageRead(peer, _, _)                             ⇒ peerRefs(peer)
      case api.messaging.UpdateMessageReadByMe(peer, _)                            ⇒ peerRefs(peer)
      case api.messaging.UpdateMessageReceived(peer, _, _)                         ⇒ peerRefs(peer)
      case api.messaging.UpdateMessageSent(peer, _, _)                             ⇒ peerRefs(peer)
      case api.messaging.UpdateMessageContentChanged(peer, _, _)                   ⇒ peerRefs(peer)
      case api.messaging.UpdateMessageDateChanged(peer, _, _)                      ⇒ peerRefs(peer)
      case api.groups.UpdateGroupAvatarChanged(groupId, userId, _, _, _)           ⇒ (Set(userId), Set(groupId))
      case api.groups.UpdateGroupInvite(groupId, inviteUserId, _, _)               ⇒ (Set(inviteUserId), Set(groupId))
      case api.groups.UpdateGroupMembersUpdate(groupId, members)                   ⇒ (members.map(_.userId).toSet ++ members.map(_.inviterUserId).toSet, Set(groupId)) // TODO: #perf use foldLeft
      case api.groups.UpdateGroupTitleChanged(groupId, userId, _, _, _)            ⇒ (Set(userId), Set(groupId))
      case api.groups.UpdateGroupUserInvited(groupId, userId, inviterUserId, _, _) ⇒ (Set(userId, inviterUserId), Set(groupId))
      case api.groups.UpdateGroupUserKick(groupId, userId, kickerUserId, _, _)     ⇒ (Set(userId, kickerUserId), Set(groupId))
      case api.groups.UpdateGroupUserLeave(groupId, userId, _, _)                  ⇒ (Set(userId), Set(groupId))
      case api.groups.UpdateGroupAboutChanged(groupId, _)                          ⇒ singleGroup(groupId)
      case api.groups.UpdateGroupTopicChanged(groupId, _, userId, _, _)            ⇒ (Set(userId), Set(groupId))
      case api.contacts.UpdateContactRegistered(userId, _, _, _)                   ⇒ singleUser(userId)
      case api.contacts.UpdateContactsAdded(userIds)                               ⇒ users(userIds)
      case api.contacts.UpdateContactsRemoved(userIds)                             ⇒ users(userIds)
      case api.users.UpdateUserAvatarChanged(userId, _)                            ⇒ singleUser(userId)
      case api.users.UpdateUserContactsChanged(userId, _)                          ⇒ singleUser(userId)
      case api.users.UpdateUserLocalNameChanged(userId, _)                         ⇒ singleUser(userId)
      case api.users.UpdateUserNameChanged(userId, _)                              ⇒ singleUser(userId)
      case api.users.UpdateUserNickChanged(userId, _)                              ⇒ singleUser(userId)
      case api.users.UpdateUserAboutChanged(userId, _)                             ⇒ singleUser(userId)
      case api.weak.UpdateGroupOnline(groupId, _)                                  ⇒ singleGroup(groupId)
      case api.weak.UpdateTyping(peer, userId, _) ⇒
        val refs = peerRefs(peer)
        refs.copy(_1 = refs._1 + userId)
      case api.weak.UpdateUserLastSeen(userId, _) ⇒ singleUser(userId)
      case api.weak.UpdateUserOffline(userId)     ⇒ singleUser(userId)
      case api.weak.UpdateUserOnline(userId)      ⇒ singleUser(userId)
      case api.calls.UpdateCallRing(user, _)      ⇒ singleUser(user.id)
      case api.calls.UpdateCallEnd(_)             ⇒ empty
      case api.counters.UpdateCountersChanged(_)  ⇒ empty
    }
  }

  def getFatMetaData(update: api.Update): FatMetaData = {
    val (userIds, groupIds) = updateRefs(update)
    FatMetaData(userIds.toSeq, groupIds.toSeq)
  }

  def subscribe(authId: Long, consumer: ActorRef)(implicit ec: ExecutionContext, ext: SeqUpdatesExtension): Future[Unit] = {
    ext.region.ref.ask(Envelope(authId, Subscribe(consumer))).mapTo[SubscribeAck].map(_ ⇒ ())
  }

  def bytesToTimestamp(bytes: Array[Byte]): Long = {
    if (bytes.isEmpty) {
      0L
    } else {
      ByteBuffer.wrap(bytes).getLong
    }
  }

  def timestampToBytes(timestamp: Long): Array[Byte] = {
    ByteBuffer.allocate(java.lang.Long.BYTES).putLong(timestamp).array()
  }

  private def pushUpdateGetSeqState(
    authId:         Long,
    header:         Int,
    serializedData: Array[Byte],
    refs:           UpdateRefs,
    pushText:       Option[String],
    originPeer:     Option[Peer],
    fatData:        Option[FatData]
  )(implicit
    ext: SeqUpdatesExtension,
    ec: ExecutionContext): Future[SeqState] = {
    ext.region.ref.ask(Envelope(authId, PushUpdateGetSequenceState(header, serializedData, refs, pushText, originPeer, fatData))).mapTo[SeqState]
  }

  def getOriginPeer(update: api.Update): Option[Peer] = {
    update match {
      case u: UpdateMessage ⇒ Some(u.peer)
      case _                ⇒ None
    }
  }
}
