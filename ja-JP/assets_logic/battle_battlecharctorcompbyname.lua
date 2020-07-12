-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_BattleCharctorCompUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CardList = ui:GetChild("CardList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


