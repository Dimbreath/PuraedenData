-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityDungeon_CheckpointUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CheckpointBtn = ui:GetChild("CheckpointBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


