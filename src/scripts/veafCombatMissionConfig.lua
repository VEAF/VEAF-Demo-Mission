-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VEAF COMBAT MISSION configuration script
-- By zip (2020)
--
-- Features:
-- ---------
-- Contains all the Caucasus mission-specific configuration for the COMBAT MISSION module
-- 
-- Prerequisite:
-- ------------
-- * This script requires DCS 2.5.1 or higher and MIST 4.3.74 or higher.
-- * It also requires veafSecurity.lua
-- 
-- Load the script:
-- ----------------
-- load it in a trigger after loading veafCombatZone
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafCombatMission then 
	veafCombatMission.logInfo("Loading configuration")
	veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setName("Test")
		:setFriendlyName("Test")
		:setBriefing("Test mission - kill the bombers")
		:addElement(
			VeafCombatMissionElement.new()
			:setName("Bombers")
			:setGroups({"Bomber - 1", "Bomber - 2"})
			:setSkill("Excellent")
			:setSpawnRadius(0)
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("< 10 minutes")
			:setDescription("the mission will be failed after 10 minutes")
			:setMessage("the 10 minutes have passed !")
			:configureAsTimedObjective(605)
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("HVT Kobuleti")
			:setDescription("the mission will be failed if 3 HVT on Kobuleti are destroyed")
			:setMessage("HVT target(s) destroyed : %s !")
			:configureAsPreventDestructionOfSceneryObjectsInZone(
				{"TestMission1-FailIfBombed-1", "TestMission1-FailIfBombed-2", "TestMission1-FailIfBombed-3"},
				{[129467721] = "Helicopter", [129467705] = "Mess", [129468118] = "Tower"}
			)
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill ONE bomber")
			:setDescription("you must kill one of the bombers")
			:setMessage("%d bomber(s) destroyed !")
			:configureAsKillEnemiesObjective(1)
		)
--[[ 		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill everyone")
			:setDescription("you must kill all the bombers")
			:configureAsKillEnemiesObjective()
		)
 ]]		:initialize()
	)
end