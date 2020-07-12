-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
require("CommonResource_ResultImageByName")
require("CommonResource_ResultDiamondLeftByName")
require("CommonResource_ResultDiamondRightByName")
require("CommonResource_SkillFrameByName")
GetCard_SkillGetGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.RedImage = ui:GetChild("RedImage")
  uis.ResultImageGrp = GetCommonResource_ResultImageUis(ui:GetChild("ResultImageGrp"))
  uis.ResultDiamondLeft = GetCommonResource_ResultDiamondLeftUis(ui:GetChild("ResultDiamondLeft"))
  uis.ResultDiamondRight = GetCommonResource_ResultDiamondRightUis(ui:GetChild("ResultDiamondRight"))
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.Decorate_06_Image = ui:GetChild("Decorate_06_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.SkillFrameGrp = GetCommonResource_SkillFrameUis(ui:GetChild("SkillFrameGrp"))
  uis.Decorate_07_Image = ui:GetChild("Decorate_07_Image")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.StageUpPropertyGrp = ui:GetChild("StageUpPropertyGrp")
  uis.root = ui
  return uis
end


