-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
GetPlotDungeon_ClearingPanelUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlotImageLoader = ui:GetChild("PlotImageLoader")
  uis.itemList = ui:GetChild("itemList")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.titleTxt = ui:GetChild("titleTxt")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Line_03Uis(ui:GetChild("DecorateImage"))
  uis.item2List = ui:GetChild("item2List")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.itemnameTxt = ui:GetChild("itemnameTxt")
  uis.describeTxt = ui:GetChild("describeTxt")
  uis.AimGrp = ui:GetChild("AimGrp")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.HeroNumberTxt = ui:GetChild("HeroNumberTxt")
  uis.Heroitem2List = ui:GetChild("Heroitem2List")
  uis.HeroAimGrp = ui:GetChild("HeroAimGrp")
  uis.confirmBtn = ui:GetChild("confirmBtn")
  uis.sweep10Btn = ui:GetChild("sweep10Btn")
  uis.sweep50Btn = ui:GetChild("sweep50Btn")
  uis.sweep1Btn = ui:GetChild("sweep1Btn")
  uis.Decorate_01_Image = GetCommonResource_Base_01Uis(ui:GetChild("Decorate_01_Image"))
  uis.Decorate_02_Image = GetCommonResource_Base_02Uis(ui:GetChild("Decorate_02_Image"))
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.vitalityTxt = ui:GetChild("vitalityTxt")
  uis.vitalitynumberTxt = ui:GetChild("vitalitynumberTxt")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.ExplainTxt = ui:GetChild("ExplainTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


