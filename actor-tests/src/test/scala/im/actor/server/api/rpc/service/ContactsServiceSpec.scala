package im.actor.server.api.rpc.service

import scala.concurrent._
import scala.concurrent.duration._

import slick.dbio.DBIO

import im.actor.api.{ rpc => api }, api._
import im.actor.server.api.util
import im.actor.server.presences.{ PresenceManagerRegion, PresenceManager }
import im.actor.server.push.{ WeakUpdatesManager, SeqUpdatesManager }

class ContactsServiceSpec extends BaseServiceSuite {
  behavior of "Contacts Service"

  "GetContacts handler" should "respond with isChanged = true and actual users if hash was emptySHA1" in s.getcontacts.changed

  it should "respond with isChanged = false if not changed" in s.getcontacts.notChanged

  "AddContact handler" should "add contact" in (s.addremove.add())

  "RemoveContact handler" should "remove contact" in (s.addremove.remove)

  "AddContact handler" should "add contact after remove" in (s.addremove.addAfterRemove)

  object s {
    implicit val seqUpdManagerRegion = SeqUpdatesManager.startRegion()
    implicit val weakUpdManagerRegion = WeakUpdatesManager.startRegion()
    implicit val presenceManagerRegion: PresenceManagerRegion = PresenceManager.startRegion()
    implicit val rpcApiService = buildRpcApiService()
    implicit val sessionRegion = buildSessionRegion(rpcApiService)

    implicit val service = new contacts.ContactsServiceImpl
    implicit val authService = buildAuthService()
    implicit val ec = system.dispatcher

    def addContact(userId: Int, userAccessSalt: String)(implicit clientData: api.ClientData) = {
      Await.result(service.handleAddContact(userId, util.ACL.userAccessHash(clientData.authId, userId, userAccessSalt)), 3.seconds)
    }

    object getcontacts {
      val (user, authId, _) = createUser()
      val sessionId = createSessionId()
      implicit val clientData = api.ClientData(authId, sessionId, Some(user.id))

      val userModels = for (i <- 1 to 3) yield {
        val user = createUser()._1.asModel()
        addContact(user.id, user.accessSalt)
        user
      }

      def changed() = {
        val expectedUsers = Await.result(db.run(DBIO.sequence(userModels map { user =>
          util.UserUtils.userStruct(user, None, clientData.authId)
        })), 3.seconds)

        whenReady(service.handleGetContacts(service.hashIds(Seq.empty))) { resp =>
          resp should matchPattern {
            case Ok(api.contacts.ResponseGetContacts(users, false)) if users == expectedUsers.toVector =>
          }
        }
      }

      def notChanged() = {
        whenReady(service.handleGetContacts(service.hashIds(userModels.map(_.id)))) { resp =>
          resp should matchPattern {
            case Ok(api.contacts.ResponseGetContacts(Vector(), true)) =>
          }
        }
      }
    }

    object addremove {
      val authId = createAuthId()
      val sessionId = createSessionId()
      val phoneNumber = buildPhone()
      val user = createUser(authId, phoneNumber)

      val (user2, _, _) = createUser()
      val user2Model = getUserModel(user2.id)
      val user2AccessHash = util.ACL.userAccessHash(authId, user2.id, user2Model.accessSalt)

      implicit val clientData = api.ClientData(authId, sessionId, Some(user.id))

      def add(firstRun: Boolean = true, expectedUpdSeq: Int = 1000) = {
        whenReady(service.handleAddContact(user2.id, user2AccessHash)) { resp =>
          resp should matchPattern {
            case Ok(api.misc.ResponseSeq(seq, state)) if seq == expectedUpdSeq =>
          }
        }

        val expectedUsers = Vector(Await.result(
          db.run(util.UserUtils.userStruct(user2Model, None, clientData.authId)),
          3.seconds
        ))

        whenReady(service.handleGetContacts(service.hashIds(Seq.empty))) { resp =>
          resp should matchPattern {
            case Ok(api.contacts.ResponseGetContacts(expectedUsers, false)) =>
          }
        }
      }

      def remove() = {
        whenReady(service.handleRemoveContact(user2.id, user2AccessHash)) { resp =>
          resp should matchPattern {
            case Ok(api.misc.ResponseSeq(1002, state)) =>
          }
        }

        whenReady(service.handleGetContacts(service.hashIds(Seq.empty))) { resp =>
          resp should matchPattern {
            case Ok(api.contacts.ResponseGetContacts(Vector(), false)) =>
          }
        }
      }

      def addAfterRemove() = add(firstRun = false, expectedUpdSeq = 1003)
    }

  }

}