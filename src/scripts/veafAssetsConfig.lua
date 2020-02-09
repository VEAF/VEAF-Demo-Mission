-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VEAF ASSETS configuration script
-- By zip (2019)
--
-- Features:
-- ---------
-- Contains all the Caucasus mission-specific configuration for the ASSETS module
-- 
-- Prerequisite:
-- ------------
-- * This script requires DCS 2.5.1 or higher and MIST 4.3.74 or higher.
-- * It also requires veafAssets.lua
-- 
-- Load the script:
-- ----------------
-- load it in a trigger after loading veafAssets
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veafAssets.logInfo("Loading configuration")

veafAssets.Assets = {
    -- list the assets common to all missions below
    {sort=1, name="Arco", description="Arco (KC-135)", information="Tacan 11Y\nVHF 251 Mhz\nZone OUEST", linked={"Arco-escort1","Arco-escort2"}}, 
    {sort=2, name="Petrolsky", description="900 (IL-78M, RED)", information="VHF 267 Mhz", linked="Petrolsky-escort"},  
}

veafAssets.logInfo("Setting move tanker radio menus")
table.insert(veafMove.Tankers, "Arco")
table.insert(veafMove.Tankers, "Petrolsky")
