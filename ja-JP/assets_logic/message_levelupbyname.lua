-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
require("CommonResource_ResultDiamondLeftByName")
require("CommonResource_ResultDiamondRightByName")
GetMessage_LevelUpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.RedImage = ui:GetChild("RedImage")
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = GetCommonResource_ResultDiamondLeftUis(ui:GetChild("Decorate_05_Image"))
  uis.Decorate_06_Image = GetCommonResource_ResultDiamondRightUis(ui:GetChild("Decorate_06_Image"))
  uis.Decorate_111_Image = ui:GetChild("Decorate_111_Image")
  uis.Decorate_11_Image = ui:GetChild("Decorate_11_Image")
  uis.Decorate_122_Image = ui:GetChild("Decorate_122_Image")
  uis.Decorate_12_Image = ui:GetChild("Decorate_12_Image")
  uis.Decorate_13_Image = ui:GetChild("Decorate_13_Image")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.Decorate_14_Image = ui:GetChild("Decorate_14_Image")
  uis.Decorate_15_Image = ui:GetChild("Decorate_15_Image")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.NumberWordTxt = ui:GetChild("NumberWordTxt")
  uis.Number_A_Txt = ui:GetChild("Number_A_Txt")
  uis.Number_B_Txt = ui:GetChild("Number_B_Txt")
  uis.TouchTxt = ui:GetChild("TouchTxt")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


