-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
GetDailyDungeon_ChoiceWifeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.Decorate_06_Image = ui:GetChild("Decorate_06_Image")
  uis.Decorate_07_Image = ui:GetChild("Decorate_07_Image")
  uis.Decorate_08_Image = ui:GetChild("Decorate_08_Image")
  uis.Decorate_09_Image = ui:GetChild("Decorate_09_Image")
  uis.Decorate_10_Image = ui:GetChild("Decorate_10_Image")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.RewardImage = ui:GetChild("RewardImage")
  uis.RewardWordTxt = ui:GetChild("RewardWordTxt")
  uis.RewardItemList = ui:GetChild("RewardItemList")
  uis.RewardTipsTxt = ui:GetChild("RewardTipsTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


