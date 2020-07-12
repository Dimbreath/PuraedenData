-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Card_CardChoicePicShowByName")
GetCard_CardChoiceUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.CardChoicePicShow = GetCard_CardChoicePicShowUis(ui:GetChild("CardChoicePicShow"))
  uis.ContentList = ui:GetChild("ContentList")
  uis.CardLookBtn = ui:GetChild("CardLookBtn")
  uis.StaticChangeBtn = ui:GetChild("StaticChangeBtn")
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.UseBtn = ui:GetChild("UseBtn")
  uis.ImageSetBtn = ui:GetChild("ImageSetBtn")
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.root = ui
  return uis
end


