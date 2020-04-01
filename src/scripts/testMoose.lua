GroupName = "test"

function spawnWithMoose()
  trigger.action.outText("spawnWithMoose()", 15)
  SPAWN:New(GroupName):Spawn()

  check()
end

function reSpawnWithMoose()
  trigger.action.outText("reSpawnWithMoose()", 15)
  SPAWN:New(GroupName):ReSpawn()

  check()
end

function spawnWithMist()
  trigger.action.outText("spawnWithMist()", 15)

  --[[
  local vars = {}
  vars.gpName = GroupName
  vars.name = GroupName
  vars.route = mist.getGroupRoute(vars.gpName, 'task')
  vars.action = 'respawn'
  vars.point = position
  local newGroup = mist.teleportToPoint(vars)
]]
  mist.respawnGroup(GroupName, true)

  check()
end

-- Function to activate BFM Area Tu-160 Bomber Wave 1 / 9 slow Tu-160
function check()
  trigger.action.outText("check()", 15)
  local group = GROUP:FindByName(GroupName)
  trigger.action.outText(string.format("Moose : found group [%s]",GroupName), 15)
  local units = group:GetUnits()
  trigger.action.outText( "Moose : #units = "..#units,  25, 15)
  local group = Group.getByName(GroupName)
  trigger.action.outText(string.format("DCS : found group [%s]",GroupName), 15)
  local units = group:getUnits()
  trigger.action.outText(string.format("DCS : found %d units",#units), 15)
end

--- =========================================================================================================

-- ===========================================
--            Radio menu management
-- ===========================================


-- Sub-menu creation
--[[

  local menu = missionCommands.addSubMenu("TEST")
  missionCommands.addCommand("spawnWithMoose", menu, spawnWithMoose)
  missionCommands.addCommand("spawnWithMist", menu, spawnWithMist)
  missionCommands.addCommand("check", menu, check)
  
  ]]
  trigger.action.outText("creating menu", 15)
  local menu = MENU_COALITION:New( coalition.side.RED, "TEST" )
  MENU_COALITION_COMMAND:New( coalition.side.RED, "spawnWithMoose", menu, spawnWithMoose )
  MENU_COALITION_COMMAND:New( coalition.side.RED, "reSpawnWithMoose", menu, reSpawnWithMoose )
  MENU_COALITION_COMMAND:New( coalition.side.RED, "spawnWithMist", menu, spawnWithMist )
  MENU_COALITION_COMMAND:New( coalition.side.RED, "check", menu, check )
  trigger.action.outText("menu is set up", 15)