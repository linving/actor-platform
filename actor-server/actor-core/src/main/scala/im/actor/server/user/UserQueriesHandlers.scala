package im.actor.server.user

import akka.pattern.pipe

import im.actor.api.rpc.users.{ User ⇒ ApiUser }
import im.actor.server.api.ApiConversions._
import im.actor.server.util.{ ACLUtils, UserUtils }
import im.actor.server.{ persist ⇒ p }

private[user] trait UserQueriesHandlers {
  self: UserProcessor ⇒

  import UserQueries._

  protected def getAuthIds(state: User): Unit = {
    sender() ! GetAuthIdsResponse(state.authIds.toSeq)
  }

  protected def getApiStruct(state: User, clientUserId: Int, clientAuthId: Long): Unit = {
    sender() ! GetApiStructResponse(ApiUser(
      id = state.id,
      accessHash = ACLUtils.userAccessHash(clientAuthId, state.id, state.accessSalt),
      name = state.name,
      localName = None,
      sex = Some(state.sex),
      avatar = state.avatar,
      phone = state.phones.headOption.orElse(Some(0)),
      isBot = Some(state.isBot),
      contactInfo = UserUtils.defaultUserContactRecords(state.phones.toVector, state.emails.toVector),
      nick = state.nickname,
      about = state.about
    ))
  }

  protected def getContactRecords(state: User): Unit = {
    sender() ! GetContactRecordsResponse(state.phones, state.emails)
  }

  protected def checkAccessHash(state: User, senderAuthId: Long, accessHash: Long): Unit =
    sender() ! CheckAccessHashResponse(isCorrect = accessHash == ACLUtils.userAccessHash(senderAuthId, userId, state.accessSalt))

}
