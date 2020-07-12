-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Shop_ShopPanelByName")
require("Shop_DiamondsByName")
GetShop_ShopWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.ShopPanelGrp = GetShop_ShopPanelUis(ui:GetChild("ShopPanelGrp"))
  uis.CommodityList = ui:GetChild("CommodityList")
  uis.TimeNameTxt = ui:GetChild("TimeNameTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.RefreshBtn = ui:GetChild("RefreshBtn")
  uis.RefreshGrp = ui:GetChild("RefreshGrp")
  uis.Diamonds = GetShop_DiamondsUis(ui:GetChild("Diamonds"))
  uis.GiftList = ui:GetChild("GiftList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


