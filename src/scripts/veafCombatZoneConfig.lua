-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VEAF COMBAT ZONE configuration script
-- By zip (2019)
--
-- Features:
-- ---------
-- Contains all the Caucasus mission-specific configuration for the COMBAT ZONE module
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
if veafCombatZone then 
	veafCombatZone.logInfo("Loading configuration")

	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("Training zone EASY-1")
			:setFriendlyName("Training zone EASY-1")
			:setBriefing("Training zone EASY-1")
			:activate()
	)
	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("Training zone MEDIUM-2")
			:setFriendlyName("Training zone MEDIUM-2")
			:setBriefing("Training zone MEDIUM-2")
			:activate()
	)
	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("Training zone MEDIUM-3")
			:setFriendlyName("Training zone MEDIUM-3")
			:setBriefing("Training zone MEDIUM-3")
			:activate()
	)
	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("Training zone HARD-4")
			:setFriendlyName("Training zone HARD-4")
			:setBriefing("Training zone HARD-4")
			:activate()
	)
	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("Training zone HARD-5")
			:setFriendlyName("Training zone HARD-5")
			:setBriefing("Training zone HARD-5")
			:activate()
	)
end