-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_EquiptPanelByName")
require("CommonResource_AssetStripByName")
require("CommonResource_EquiptIconBigByName")
GetEquipt_EquiptUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.CardShowLoader = ui:GetChild("CardShowLoader")
  uis.EquiptPanelGrp = GetEquipt_EquiptPanelUis(ui:GetChild("EquiptPanelGrp"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.EquiptIconBigImage = ui:GetChild("EquiptIconBigImage")
  uis.WeaponGrp = GetCommonResource_EquiptIconBigUis(ui:GetChild("WeaponGrp"))
  uis.ClothesGrp = GetCommonResource_EquiptIconBigUis(ui:GetChild("ClothesGrp"))
  uis.NecklaceGrp = GetCommonResource_EquiptIconBigUis(ui:GetChild("NecklaceGrp"))
  uis.RingGrp = GetCommonResource_EquiptIconBigUis(ui:GetChild("RingGrp"))
  uis.EquiptIconBigGrp = ui:GetChild("EquiptIconBigGrp")
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.CardHeadGrp = ui:GetChild("CardHeadGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


