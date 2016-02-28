local ObjectManager = require("managers.object.object_manager")
local QuestManager = require("managers.quest.quest_manager")

FsSad = ScreenPlay:new {
	--timePeriod = 24 * 60 * 60, -- 24 Hours
	timePeriod = 1 * 60 * 60, -- 1 hour for testing
	tasksPerPeriod = 3,
	theaterTable = { FsSad1Theater1, FsSad1Theater2, FsSad1Theater3, FsSad1Theater4, FsSad1Theater5, FsSad1Theater6, FsSad1Theater7, FsSad1Theater8 }
}

function FsSad:hasExceededLimit(pPlayer)
	local lastTimestamp = self:getLastTimestamp(pPlayer)
	local tasksSinceLast = self:getTasksSinceLastTimestamp(pPlayer)

	if ((os.difftime(os.time(), lastTimestamp) < self.timePeriod) and tasksSinceLast >= self.tasksPerPeriod) then
		return true
	end

	return false
end

function FsSad:updateLastTimestamp(pPlayer)
	writeScreenPlayData(pPlayer, "VillageJediProgression", "FsSadLastLimitReset", os.time())
end

function FsSad:getLastTimestamp(pPlayer)
	local lastTimestamp = readScreenPlayData(pPlayer, "VillageJediProgression", "FsSadLastLimitReset")

	if (lastTimestamp == "") then
		self:updateLastTimestamp(pPlayer)
		return os.time()
	end

	return tonumber(lastTimestamp)
end

function FsSad:setTasksSinceLastTimestamp(pPlayer, count)
	writeScreenPlayData(pPlayer, "VillageJediProgression", "FsSadTasksSinceLastTimestamp", count)
end

function FsSad:getTasksSinceLastTimestamp(pPlayer)
	local count = readScreenPlayData(pPlayer, "VillageJediProgression", "FsSadTasksSinceLastTimestamp")

	if (count == "") then
		count = 0
		self:setTasksSinceLastTimestamp(pPlayer, count)
	end

	return tonumber(count)
end

function FsSad:acceptNextTask(pPlayer)
	local lastTimestamp = self:getLastTimestamp(pPlayer)

	if (os.difftime(os.time(), lastTimestamp) > self.timePeriod) then
		self:updateLastTimestamp(pPlayer)
		self:setTasksSinceLastTimestamp(pPlayer, 1)
	else
		local tasksSinceLast = self:getTasksSinceLastTimestamp(pPlayer)
		self:setTasksSinceLastTimestamp(pPlayer, tasksSinceLast + 1)
	end

	if (not QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.FS_QUESTS_SAD_TASKS) and not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.FS_QUESTS_SAD_TASKS)) then
		QuestManager.activateQuest(pPlayer, QuestManager.quests.FS_QUESTS_SAD_TASKS)
		VillageJediManagerCommon.setActiveQuestThisPhase(pPlayer)

		if (not SuiRadiationSensor:hasSensor(pPlayer)) then
			SuiRadiationSensor:giveSensor(pPlayer)
		end

		self:startTask(pPlayer, QuestManager.quests.FS_QUESTS_SAD_TASK1, 1)
	else
		for i = 1, 8, 1 do
			local questID = getPlayerQuestID("fs_quests_sad_return" .. i)

			if QuestManager.hasActiveQuest(pPlayer, questID) then
				QuestManager.completeQuest(pPlayer, questID)
				self:finishOldTask(pPlayer, i)

				if (i == 8) then
					self:completeSeries(pPlayer, questID)
				else
					local newQuestID = getPlayerQuestID("fs_quests_sad_task" .. i + 1)
					self:startTask(pPlayer, newQuestID, i + 1)
				end
			else
			end
		end
	end
end

function FsSad:completeSeries(pPlayer, questID)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.FS_QUESTS_SAD_TASKS)
	QuestManager.completeQuest(pPlayer, QuestManager.quests.FS_QUESTS_SAD_FINISH)
	VillageJediManagerCommon.setCompletedQuestThisPhase(pPlayer)
	VillageJediManagerCommon.unlockBranch(pPlayer, "force_sensitive_combat_prowess_melee_speed")
	SuiRadiationSensor:removeSensor(pPlayer)

	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

	if (pInventory ~= nil) then
		local pPowerup = giveItem(pInventory, "object/tangible/powerup/weapon/fs_quest_sad/melee_speed_quest.iff", -1, true)

		if (pPowerup ~= nil) then
			LuaPowerupObject(pPowerup):setUses(500)
			LuaPowerupObject(pPowerup):addPowerupStat("attackSpeed", "Control Enhancement", "cat_pup.pup_wpn_attack_speed", 30)
			LuaPowerupObject(pPowerup):setType("melee")
		end
	end
end

function FsSad:doPhaseChangeFail(pPlayer)
	if (not QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.FS_QUESTS_SAD_TASKS) or QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.FS_QUESTS_SAD_FINISH)) then
		return
	end

	CreatureObject(pPlayer):sendSystemMessage("@quest/quest_journal/fs_quests_sad:wrong_phase")

	if QuestManager.hasCompletedQuest(pPlayer, QuestManager.quests.FS_QUESTS_SAD_TASKS) or QuestManager.hasActiveQuest(pPlayer, QuestManager.quests.FS_QUESTS_SAD_TASKS) then
		QuestManager.resetQuest(pPlayer, QuestManager.quests.FS_QUESTS_SAD_TASKS)
	end

	for i = 1, 8, 1 do
		local questName = "fs_quests_sad_task" .. i
		local questID = getPlayerQuestID(questName)

		if QuestManager.hasCompletedQuest(pPlayer, questID) or QuestManager.hasActiveQuest(pPlayer, questID) then
			QuestManager.resetQuest(pPlayer, questID)
		end
	end

	SuiRadiationSensor:removeSensor(pPlayer)
end

function FsSad:finishOldTask(pPlayer, questNum)
	local FsSadTheater = self.theaterTable[questNum]

	FsSadTheater:finish(pPlayer)
end

function FsSad:startTask(pPlayer, questID, questNum)
	QuestManager.activateQuest(pPlayer, questID)

	local FsSadTheater = self.theaterTable[questNum]

	FsSadTheater:start(pPlayer)
end

function FsSad:hasActiveReturnTask(pPlayer)
	for i = 1, 8, 1 do
		local questID = getPlayerQuestID("fs_quests_sad_return" .. i)

		if QuestManager.hasActiveQuest(pPlayer, questID) then
			return true
		end
	end

	return false
end

function FsSad:hasActiveNonReturnTask(pPlayer)
	for i = 1, 8, 1 do
		local questID = getPlayerQuestID("fs_quests_sad_task" .. i)

		if QuestManager.hasActiveQuest(pPlayer, questID) then
			return true
		end
	end

	return false
end

function FsSad:hasFullInventory(pPlayer)
	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")

	if (pInventory == nil) then
		return true
	end

	return SceneObject(pInventory):isContainerFullRecursive()
end

return FsSad