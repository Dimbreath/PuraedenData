-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
require("Card_LevelUpEffectByName")
require("Card_LevelItemByName")
GetCard_LevelGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.DecorateGrp = ui:GetChild("DecorateGrp")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.HeadFrame = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrame"))
  uis.UpGrp = GetCard_LevelUpEffectUis(ui:GetChild("UpGrp"))
  uis.ItemOneGrp = GetCard_LevelItemUis(ui:GetChild("ItemOneGrp"))
  uis.ItemTwoGrp = GetCard_LevelItemUis(ui:GetChild("ItemTwoGrp"))
  uis.ItemThreeGrp = GetCard_LevelItemUis(ui:GetChild("ItemThreeGrp"))
  uis.ItemFourGrp = GetCard_LevelItemUis(ui:GetChild("ItemFourGrp"))
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.ExpProgressBar = ui:GetChild("ExpProgressBar")
  uis.LvTxt = ui:GetChild("LvTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.ExpTxt = ui:GetChild("ExpTxt")
  uis.LevelUpBarGrp = ui:GetChild("LevelUpBarGrp")
  uis.root = ui
  return uis
end


