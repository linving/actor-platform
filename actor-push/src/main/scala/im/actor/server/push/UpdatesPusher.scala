package im.actor.server.push

import scala.concurrent._
import scala.concurrent.duration._

import akka.actor._
import akka.util.Timeout
import org.joda.time.DateTime
import slick.driver.PostgresDriver.api._

import im.actor.api.rpc.codecs.UpdateBoxCodec
import im.actor.api.rpc.messaging.UpdateMessageSent
import im.actor.api.rpc.sequence.WeakUpdate
import im.actor.api.rpc.weak.{ UpdateUserLastSeen, UpdateUserOffline, UpdateUserOnline }
import im.actor.api.rpc.{ Update, UpdateBox ⇒ ProtoUpdateBox }
import im.actor.server.models
import im.actor.server.mtproto.protocol.UpdateBox
import im.actor.server.presences.{ PresenceManager, PresenceManagerRegion }
import im.actor.server.session.SessionMessage

object UpdatesPusher {

  @SerialVersionUID(1L)
  private object SubscribeToSeq

  @SerialVersionUID(1L)
  private object SubscribeToWeak

  @SerialVersionUID(1L)
  case class SubscribeToUserPresences(userIds: Set[Int])

  @SerialVersionUID(1L)
  case class UnsubscribeFromUserPresences(userIds: Set[Int])

  def props(authId: Long, session: ActorRef)(implicit
    seqUpdatesManagerRegion: SeqUpdatesManagerRegion,
                                             weakUpdatesManagerRegion: WeakUpdatesManagerRegion,
                                             presenceManagerRegion:    PresenceManagerRegion,
                                             db:                       Database) =
    Props(
      classOf[UpdatesPusher],
      authId,
      session,
      seqUpdatesManagerRegion,
      weakUpdatesManagerRegion,
      presenceManagerRegion,
      db
    )
}

private[push] class UpdatesPusher(
  authId:                                Long,
  session:                               ActorRef,
  implicit val seqUpdatesManagerRegion:  SeqUpdatesManagerRegion,
  implicit val weakUpdatesManagerRegion: WeakUpdatesManagerRegion,
  implicit val presenceManagerRegion:    PresenceManagerRegion,
  implicit val db:                       Database
)
  extends Actor with ActorLogging with Stash {

  import PresenceManager._
  import SessionMessage._
  import UpdatesPusher._

  @SerialVersionUID(1L)
  private case class Initiated(
    googlePushCredentials: Option[models.push.GooglePushCredentials],
    applePushCredentials:  Option[models.push.ApplePushCredentials]
  )

  implicit val ec: ExecutionContext = context.dispatcher
  implicit val system: ActorSystem = context.system
  implicit val timeout: Timeout = Timeout(5.seconds) // TODO: configurable

  override def preStart(): Unit = {
    self ! SubscribeToSeq

    self ! SubscribeToWeak
  }

  def receive = {
    case SubscribeToSeq ⇒
      SeqUpdatesManager.subscribe(authId, self) onFailure {
        case e ⇒
          self ! SubscribeToSeq
          log.error(e, "Failed to subscribe to sequence updates")
      }
    case SubscribeToWeak ⇒
      WeakUpdatesManager.subscribe(authId, self) onFailure {
        case e ⇒
          self ! SubscribeToWeak
          log.error(e, "Failed to subscribe to weak updates")
      }
    case cmd @ SubscribeToUserPresences(userIds) ⇒
      userIds foreach { userId ⇒
        PresenceManager.subscribe(userId, self) onFailure {
          case e ⇒
            self ! cmd
            log.error(e, "Failed to subscribe to presences")
        }
      }
    case cmd @ UnsubscribeFromUserPresences(userIds) ⇒
      userIds foreach { userId ⇒
        PresenceManager.unsubscribe(userId, self) onFailure {
          case e ⇒
            self ! cmd
            log.error(e, "Failed to subscribe from presences")
        }
      }
    case SeqUpdatesManager.UpdateReceived(updateBox) ⇒
      if (updateBox.updateHeader != UpdateMessageSent.header) {
        sendUpdateBox(updateBox)
      }
    case WeakUpdatesManager.UpdateReceived(updateBox) ⇒
      sendUpdateBox(updateBox)
    case PresenceState(userId, presence, lastSeenAt) ⇒
      log.debug("presence: {}, lastSeenAt {}", presence, lastSeenAt)

      val update: Update =
        presence match {
          case Online ⇒
            UpdateUserOnline(userId)
          case Offline ⇒
            lastSeenAt match {
              case Some(date) ⇒
                UpdateUserLastSeen(userId, date.getMillis / 1000)
              case None ⇒
                UpdateUserOffline(userId)
            }
        }

      log.debug("Formed update: {}", update)

      val updateBox = WeakUpdate((new DateTime).getMillis, update.header, update.toByteArray)
      sendUpdateBox(updateBox)
  }

  private def sendUpdateBox(updateBox: ProtoUpdateBox): Unit = {
    val ub = UpdateBox(UpdateBoxCodec.encode(updateBox).require)
    session ! SendProtoMessage(ub)
  }
}