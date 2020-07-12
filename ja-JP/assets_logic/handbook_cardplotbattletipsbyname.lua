-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_CardPlotBattleEffectByName")
GetHandBook_CardPlotBattleTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardPlotBattleEffect = GetHandBook_CardPlotBattleEffectUis(ui:GetChild("CardPlotBattleEffect"))
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


