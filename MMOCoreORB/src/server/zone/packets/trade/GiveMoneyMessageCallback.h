/*
 * GiveMoneyMessageCallback.h
 *
 *  Created on: 07/06/2010
 *      Author: victor
 */

#ifndef GIVEMONEYMESSAGECALLBACK_H_
#define GIVEMONEYMESSAGECALLBACK_H_

#include "server/zone/packets/MessageCallback.h"
#include "server/zone/managers/player/PlayerManager.h"

class GiveMoneyMessageCallback : public MessageCallback {
	uint32 money;

public:
	GiveMoneyMessageCallback(ZoneClientSession* client, ZoneProcessServer* server) :
		MessageCallback(client, server), money(0) {

	}

	void parse(Message* message) {
		money = message->parseInt();
	}

	void run() {
		ManagedReference<CreatureObject*> player = client->getPlayer();

		if (player == nullptr)
			return;

		auto zoneServer = server->getZoneServer();

		if (zoneServer == nullptr)
			return;

		auto playerMan = zoneServer->getPlayerManager();

		if (playerMan == nullptr)
			return;

		Locker lock(player);

		playerMan->handleGiveMoneyMessage(player, money);
	}

};


#endif /* GIVEMONEYMESSAGECALLBACK_H_ */
