-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("CommonResource_AllItemIconByName")
GetGift_GiftItemUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.Item = GetCommonResource_AllItemIconUis(ui:GetChild("Item"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.ChoiceBtn = ui:GetChild("ChoiceBtn")
  uis.StarList = ui:GetChild("StarList")
  uis.GiftCardLabelList = ui:GetChild("GiftCardLabelList")
  uis.HaveTxt = ui:GetChild("HaveTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


