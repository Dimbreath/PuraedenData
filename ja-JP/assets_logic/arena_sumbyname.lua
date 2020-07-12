-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
require("CommonResource_ResultDiamondLeftByName")
require("CommonResource_ResultDiamondRightByName")
GetArena_SumUis = function(ui, ...)
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
  uis.TouchTxt = ui:GetChild("TouchTxt")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.SumTipsList = ui:GetChild("SumTipsList")
  uis.root = ui
  return uis
end


