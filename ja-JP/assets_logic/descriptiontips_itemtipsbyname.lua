-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_ItemFrameByName")
require("CommonResource_HeadDebrisByName")
require("CommonResource_EquiptIconByName")
GetDescriptionTips_ItemTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TipsImage = ui:GetChild("TipsImage")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.ItemFrameGrp = GetCommonResource_ItemFrameUis(ui:GetChild("ItemFrameGrp"))
  uis.HeadDebrisGrp = GetCommonResource_HeadDebrisUis(ui:GetChild("HeadDebrisGrp"))
  uis.EquiotIcon = GetCommonResource_EquiptIconUis(ui:GetChild("EquiotIcon"))
  uis.ItemNameTxt = ui:GetChild("ItemNameTxt")
  uis.ItemWordTxt = ui:GetChild("ItemWordTxt")
  uis.BuyImage = ui:GetChild("BuyImage")
  uis.BuyNumberTxt = ui:GetChild("BuyNumberTxt")
  uis.BuyGrp = ui:GetChild("BuyGrp")
  uis.HaveNumber_01_Txt = ui:GetChild("HaveNumber_01_Txt")
  uis.HaveNumberTxt = ui:GetChild("HaveNumberTxt")
  uis.HaveNumberGrp = ui:GetChild("HaveNumberGrp")
  uis.Equipt_01_Txt = ui:GetChild("Equipt_01_Txt")
  uis.Equipt_03_Txt = ui:GetChild("Equipt_03_Txt")
  uis.EquiptGrp = ui:GetChild("EquiptGrp")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.LvUseTxt = ui:GetChild("LvUseTxt")
  uis.ItemTipsGrp = ui:GetChild("ItemTipsGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


