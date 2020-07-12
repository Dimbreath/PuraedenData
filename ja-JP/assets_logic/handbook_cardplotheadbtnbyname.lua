-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_CardPlotHeadByName")
GetHandBook_CardPlotHeadBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardPlotHead = GetHandBook_CardPlotHeadUis(ui:GetChild("CardPlotHead"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


