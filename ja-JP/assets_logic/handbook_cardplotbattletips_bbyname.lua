-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_CardPlotHead_BByName")
GetHandBook_CardPlotBattleTips_BUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardPlotHead = GetHandBook_CardPlotHead_BUis(ui:GetChild("CardPlotHead"))
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


