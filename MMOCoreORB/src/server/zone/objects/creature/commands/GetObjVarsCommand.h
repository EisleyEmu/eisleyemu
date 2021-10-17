/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef GETOBJVARSCOMMAND_H_
#define GETOBJVARSCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/chat/ChatManager.h"

class GetObjVarsCommand : public QueueCommand {
public:

	GetObjVarsCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (!creature->isPlayerCreature())
			return GENERALERROR;

		uint64 objectID = 0;
		UnicodeTokenizer tokenizer(arguments);
		tokenizer.setDelimeter(" ");

		// if we have an argument passed, use it
		if (tokenizer.hasMoreTokens()) {
			try {
				objectID = tokenizer.getLongToken();
			} catch ( Exception& err ) {
				creature->sendSystemMessage("INVALID OBJECT.  Please specify a valid object name or objectid");
				return INVALIDPARAMETERS;
			}
		} else {
			objectID = target;
		}

		if ( objectID == 0 ) {
			creature->sendSystemMessage("You need to target an object or specify an object id: /getobjvars <objectID> ");
		}

		ManagedReference<SceneObject*> object = server->getZoneServer()->getObject(objectID, false);

		if ( object == nullptr) {
			creature->sendSystemMessage("ERROR GETTIGN OBJECT - nullptr " + String::valueOf(objectID));
		} else {

			String strClassName = object->getObjectNameStringIdName();
			String strDescription = object->getDetailedDescription();
			bool bMarkedForDelete = object->_isMarkedForDeletion();
			bool bIsUpdated = object->_isUpdated();
			int rCount = object.get()->getReferenceCount();
			uint64 parentID = object->getParentID();
			StringBuffer msg;
			msg << endl << "OBJECTID: " << String::valueOf(objectID) << endl;
			msg << "OBJECTTYPE: " << String::valueOf(object->getGameObjectType()) << endl;

			if(object->isCreatureObject()) {
				msg << "Creature First Name: " << object.castTo<CreatureObject*>()->getFirstName() << endl;
			}

			msg << "CLASS: " << strClassName << endl;
			msg << "Marked for deletion: " << String::valueOf(bMarkedForDelete) << endl;
			msg << "IsUpdated: " <<  String::valueOf(bIsUpdated) << endl;
			msg << "REFERENCE COUNT " << String::valueOf(rCount) << endl;
			msg << "Path: " << object->getObjectTemplate()->getFullTemplateString() << endl;
			msg << "Children: " << String::valueOf(object->getChildObjects()->size()) << endl;
			msg << "PARENT OBJECTID: " << String::valueOf(parentID) << endl;

			if (object->isAiAgent()) {
				AiAgent* objectAgent = object->asAiAgent();

				if (objectAgent != nullptr) {
					String aiEnabled = (objectAgent->getOptionsBitmask() & OptionBitmask::AIENABLED ? "True" : "False");
					msg << "AI Enabled: " << aiEnabled << endl;
					msg << "Creature Bitmask: " << objectAgent->getCreatureBitmask() << endl;
					msg << "PvP Status Bitmask: " << objectAgent->getPvpStatusBitmask() << endl;
					msg << "Options Bitmask: " << objectAgent->getOptionsBitmask() << endl;
				}
			}

			if(object->getZone() != nullptr)
				msg << "location: " << String::valueOf(object->getPositionX()) << " "  << String::valueOf(object->getPositionY()) << " " << object->getZone()->getZoneName() << endl;

			ManagedReference<CityRegion*> city = object->getCityRegion().get();
			if (city != nullptr)
				msg << "City Region oid: " << String::valueOf(city->getObjectID()) << ", name: " << city->getRegionDisplayedName() << endl;

			creature->sendSystemMessage(msg.toString());

			ChatManager* chatManager = server->getZoneServer()->getChatManager();
			String title = "getObjVars - " + String::valueOf(objectID);
			chatManager->sendMail("System", title , msg.toString(), creature->getFirstName());
		}


		return SUCCESS;
	}

};

#endif //GETOBJVARSCOMMAND_H_
