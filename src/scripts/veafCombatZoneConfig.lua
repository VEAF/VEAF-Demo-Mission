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
			:setMissionEditorZoneName("combatZone_CrossKobuleti")
			:setFriendlyName("Cross Kobuleti")
			:setBriefing("This is a simple mission\n" ..
						 "You must destroy the comm antenna before 11:30 local time\n" ..
						 "The other ennemy units are secondary targets\n")
	)
	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("combatZone_Batumi")
			:setFriendlyName("Batumi")
			:setBriefing("This is a second test mission")
	)
end