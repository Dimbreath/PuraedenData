-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
require("CommonResource_ResultImageByName")
require("CommonResource_ResultDiamondLeftByName")
require("CommonResource_ResultDiamondRightByName")
GetMessage_RewardShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.RedImage = ui:GetChild("RedImage")
  uis.ResultImageGrp = GetCommonResource_ResultImageUis(ui:GetChild("ResultImageGrp"))
  uis.ResultDiamondLeft = GetCommonResource_ResultDiamondLeftUis(ui:GetChild("ResultDiamondLeft"))
  uis.ResultDiamondRight = GetCommonResource_ResultDiamondRightUis(ui:GetChild("ResultDiamondRight"))
  uis.Decorate_11_Image = ui:GetChild("Decorate_11_Image")
  uis.Decorate_12_Image = ui:GetChild("Decorate_12_Image")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.ItemIconList = ui:GetChild("ItemIconList")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.RewardShowGrp = ui:GetChild("RewardShowGrp")
  uis.root = ui
  return uis
end


