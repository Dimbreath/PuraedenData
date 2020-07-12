-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_CirclePropFrameByName")
require("CommonResource_HeadFrameByName")
require("Card_StageUpEffectByName")
require("Card_StageEffectByName")
GetCard_StageGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.DecorateGrp = ui:GetChild("DecorateGrp")
  uis.MaxStageGrp = ui:GetChild("MaxStageGrp")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.GoldBackImage = ui:GetChild("GoldBackImage")
  uis.GoldImage = ui:GetChild("GoldImage")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.StageUpWordTxt = ui:GetChild("StageUpWordTxt")
  uis.ButtonTwoBtn = ui:GetChild("ButtonTwoBtn")
  uis.ItemOneGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemOneGrp"))
  uis.ItemTwoGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemTwoGrp"))
  uis.ItemThreeGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemThreeGrp"))
  uis.ItemSixGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemSixGrp"))
  uis.ItemFiveGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemFiveGrp"))
  uis.ItemFourGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemFourGrp"))
  uis.HeadFrame = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrame"))
  uis.UpGrp = GetCard_StageUpEffectUis(ui:GetChild("UpGrp"))
  uis.StageNumberTxt = ui:GetChild("StageNumberTxt")
  uis.StageEffectGrp = GetCard_StageEffectUis(ui:GetChild("StageEffectGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


