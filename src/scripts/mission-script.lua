-- mission-script.lua
-- Mission-specific Lua code that cannot be generated from mission.yaml.
--
-- Loaded AFTER veaf-config.lua, which is generated from mission.yaml at build time. That order is what
-- makes the wiring at the bottom of this file work: the combat zones and the AirWaves zones exist by then.
--
-- Put here:
--   - callbacks and hooks, which are code and cannot live in YAML
--   - custom shortcuts / aliases (VeafAlias:new():…)
--   - custom Lua helper functions
--
-- Do NOT put here:
--   - module initialisation      → mission.yaml (modules:)
--   - mission identity           → mission.yaml (mission:)
--   - QRA definitions            → mission.yaml (modules.QRA)
--   - combat/CAP missions        → mission.yaml (combat_missions: / cap_missions:)
--   - asset lists                → mission.yaml (modules.ASSETS.assets)

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════
-- Callbacks recovered from the v5 mission
--
-- `convert-v5` could not express these in mission.yaml and left them as commented-out TODOs, so the
-- mission lost three behaviours it used to have. They are restored below, from
-- `missionConfig.lua` in the v5 backup — the line numbers cited are that file's.
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════

--- Bomb a crippled enemy unit rather than let it linger.
---
--- From missionConfig.lua:119-129, where it was **active**. An AirWaves wave is only "destroyed" when its
--- groups are dead; a unit at 40 % life that no longer shoots keeps the wave alive forever, so the mission
--- finishes it off.
local function handleCrippledEnemyUnit(zone, waveNumber, unit)
  veaf.loggers.get(veafAirWaves.Id):trace("zone[%s]->handleCrippledEnemyUnit(%s)", veaf.p(zone:getName()), veaf.p(waveNumber))
  if not unit then
    return
  end
  veaf.loggers.get(veafAirWaves.Id):trace("unit:getName()=%s", veaf.p(unit:getName()))
  -- bomb the bastard
  local spot = unit:getPosition().p
  local power = 50
  trigger.action.explosion(spot, power)
end

--- Announce the end of the Gori combat zone.
---
--- From missionConfig.lua:453-455, where it was **active** on `subCombatZone_gori`.
local function onGoriEnd(zone)
  trigger.action.outText(string.format("Hook on %s", zone:getFriendlyName()), 10)
end

--- Decide whether an AI enemy group counts as dead — radar-aware for the S-300.
---
--- From missionConfig.lua:64-116, where it was **already commented out** (`--:setIsEnemyGroupDeadCallback`).
--- Kept here, and kept disabled, so the decision to leave it off stays a decision rather than an accident:
--- an S-300 site whose launchers live but whose tracking and search radars are gone cannot fight, and this
--- would let a wave complete on that basis. Uncomment the wiring at the bottom to enable it.
---
--- Note it calls `zone.handleCrippledEnemyUnitCallback`, so it only makes sense with the callback above.
local function isEnemyGroupDead(zone, waveNumber, group)
  veaf.loggers.get(veafAirWaves.Id):trace("zone[%s]->isEnemyGroupDead(%s)", veaf.p(zone:getName()), veaf.p(waveNumber))
  if not group then
    return
  end
  local groupAlive = false
  veaf.loggers.get(veafAirWaves.Id):trace("group:getName()=%s", veaf.p(group:getName()))
  if group:getName():lower():match(".*s300.*") then
    local importantUnitsAlive = {}
    importantUnitsAlive["S-300PS 40B6M tr"] = false
    importantUnitsAlive["S-300PS 40B6MD sr"] = false
    importantUnitsAlive["S-300PS 64H6E sr"] = false
    importantUnitsAlive["S-300PS 54K6 cp"] = false

    -- A set is alive if ANY of its members is: two search radars are redundant, the tracking radar and
    -- the command post are not.
    local importantSetsAlive = {}
    importantSetsAlive["TR"] = { "S-300PS 40B6M tr" }
    importantSetsAlive["SR"] = { "S-300PS 40B6MD sr", "S-300PS 64H6E sr" }
    importantSetsAlive["CP"] = { "S-300PS 54K6 cp" }

    -- this is a SA10, consider the radar
    for _, unit in pairs(group:getUnits()) do
      local typeName = unit:getTypeName()
      local unitLifePercent = 100 * unit:getLife() / unit:getLife0()
      veaf.loggers.get(veafAirWaves.Id):trace("unit %s (%s) at %s%%", veaf.p(unit:getName()), veaf.p(typeName), veaf.p(unitLifePercent))
      if unitLifePercent >= 100 then
        if importantUnitsAlive[typeName] ~= nil then
          importantUnitsAlive[typeName] = true
        end
      else
        zone.handleCrippledEnemyUnitCallback(zone, waveNumber, unit)
      end
    end
    -- check that all the important units are alive
    veaf.loggers.get(veafAirWaves.Id):trace("importantUnitsAlive=%s", veaf.p(importantUnitsAlive))
    groupAlive = true
    for importantSetName, importantSet in pairs(importantSetsAlive) do
      local setAlive = false
      for _, typeName in pairs(importantSet) do
        setAlive = setAlive or importantUnitsAlive[typeName]
      end
      veaf.loggers.get(veafAirWaves.Id):trace("set %s alive=%s", veaf.p(importantSetName), veaf.p(setAlive))
      groupAlive = groupAlive and setAlive
    end
    veaf.loggers.get(veafAirWaves.Id):trace("groupAlive=%s", veaf.p(groupAlive))
  end
  return not groupAlive
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════
-- Wiring
--
-- Guarded on the zone existing. `veafAirWaves.get` returns nil for an unknown name and
-- `veafCombatZone.GetZone` complains and returns nil, so an unguarded call here would either fail the
-- whole script or fill the log on a mission where the zone was renamed.
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════

local airWaveZone = veafAirWaves.get("Zone 01")
if airWaveZone then
  -- From missionConfig.lua:221-223. Raises the flag the mission's own triggers watch.
  airWaveZone:setOnDeploy(function()
    trigger.action.setUserFlag("monBeauDrapeau", 1)
  end)
  airWaveZone:setHandleCrippledEnemyUnitCallback(handleCrippledEnemyUnit)

  -- Disabled in v5 as well — see isEnemyGroupDead above.
  -- airWaveZone:setIsEnemyGroupDeadCallback(isEnemyGroupDead)
else
  veaf.loggers.get(veaf.Id):warn("mission-script: no AirWaves zone named [Zone 01]; its callbacks are not wired")
end

local goriZone = veafCombatZone.GetZone("subCombatZone_gori")
if goriZone then
  goriZone:setOnCompletedHook(onGoriEnd)
end
