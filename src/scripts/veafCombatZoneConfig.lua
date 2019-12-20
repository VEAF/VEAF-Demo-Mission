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
veafCombatZone.logInfo("Loading configuration")

veafCombatZone.addZone(
	Zone:new()
		:setMissionEditorZoneName("combatZoneCrossKobuleti")
		:setFriendlyName("Cross Kobuleti")
)