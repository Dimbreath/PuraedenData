-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_IntimacyPanelBtnBgByName")
require("CommonResource_RedDollByName")
GetHandBook_IntimacyPanelBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n6 = GetHandBook_IntimacyPanelBtnBgUis(ui:GetChild("n6"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


