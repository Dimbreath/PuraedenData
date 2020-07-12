-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_PictureEffectByName")
require("CommonResource_AssetStripByName")
require("Card_MessageGrpByName")
require("Card_PanelByName")
require("Card_CardInfoByName")
GetCard_CardWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.PictureEffect = GetCard_PictureEffectUis(ui:GetChild("PictureEffect"))
  uis.PictureLoader = ui:GetChild("PictureLoader")
  uis.R_Image = ui:GetChild("R_Image")
  uis.SR_Image = ui:GetChild("SR_Image")
  uis.SSR_Image = ui:GetChild("SSR_Image")
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.MessageGrp = GetCard_MessageGrpUis(ui:GetChild("MessageGrp"))
  uis.PropertyBtn = ui:GetChild("PropertyBtn")
  uis.IfoGrp = ui:GetChild("IfoGrp")
  uis.PanelGrp = GetCard_PanelUis(ui:GetChild("PanelGrp"))
  uis.JueseNameLoader = ui:GetChild("JueseNameLoader")
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.CardInfoGrp = GetCard_CardInfoUis(ui:GetChild("CardInfoGrp"))
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


