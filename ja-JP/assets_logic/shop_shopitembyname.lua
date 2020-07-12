-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_SaleTipCompByName")
require("CommonResource_RedDollByName")
require("Shop_CardUseByName")
require("Shop_DayBuyByName")
require("CommonResource_NewCompByName")
GetShop_ShopItemUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ItemNameTxt = ui:GetChild("ItemNameTxt")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.SaleTipCompGrp = GetShop_SaleTipCompUis(ui:GetChild("SaleTipCompGrp"))
  uis.RedDollGrp = GetCommonResource_RedDollUis(ui:GetChild("RedDollGrp"))
  uis.CardUse = GetShop_CardUseUis(ui:GetChild("CardUse"))
  uis.DayBuy = GetShop_DayBuyUis(ui:GetChild("DayBuy"))
  uis.NewCompGrp = GetCommonResource_NewCompUis(ui:GetChild("NewCompGrp"))
  uis.IconNumberTxt = ui:GetChild("IconNumberTxt")
  uis.BuyEnd_01_Image = ui:GetChild("BuyEnd_01_Image")
  uis.BuyEndGrp = ui:GetChild("BuyEndGrp")
  uis.CostLoader = ui:GetChild("CostLoader")
  uis.CostTxt = ui:GetChild("CostTxt")
  uis.CostFreeImage = ui:GetChild("CostFreeImage")
  uis.EquiptStarList = ui:GetChild("EquiptStarList")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


