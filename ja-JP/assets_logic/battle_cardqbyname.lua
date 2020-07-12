-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_CardQUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


