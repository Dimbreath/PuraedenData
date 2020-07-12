-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_CharctorCompUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.HeadIconLoader = ui:GetChild("HeadIconLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


