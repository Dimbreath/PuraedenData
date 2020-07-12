-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_ChoiceBtnBgByName")
require("CommonResource_RedDollByName")
GetShop_ChoiceBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChoiceBtnBg = GetShop_ChoiceBtnBgUis(ui:GetChild("ChoiceBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.lockCtr = ui:GetController("lock")
  uis.root = ui
  return uis
end


