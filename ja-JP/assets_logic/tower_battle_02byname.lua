-- params : ...
-- function num : 0 , upvalues : _ENV
GetTower_Battle_02Uis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.EquiptIconList = ui:GetChild("EquiptIconList")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


