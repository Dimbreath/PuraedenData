-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_LayerCutByName")
GetTower_LayerBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.LayerCutGrp = GetTower_LayerCutUis(ui:GetChild("LayerCutGrp"))
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


