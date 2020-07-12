-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_CardLabelByName")
GetCard_DetailedContentUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.DecorateGrp = ui:GetChild("DecorateGrp")
  uis.JueseNameLoader = ui:GetChild("JueseNameLoader")
  uis.AptitudeIcon_UR_Image = ui:GetChild("AptitudeIcon_UR_Image")
  uis.AptitudeIcon_SSR_Image = ui:GetChild("AptitudeIcon_SSR_Image")
  uis.AptitudeIcon_SR_Image = ui:GetChild("AptitudeIcon_SR_Image")
  uis.AptitudeIcon_R_Image = ui:GetChild("AptitudeIcon_R_Image")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.StarList = ui:GetChild("StarList")
  uis.StageNumberTxt = ui:GetChild("StageNumberTxt")
  uis.One = GetCommonResource_CardLabelUis(ui:GetChild("One"))
  uis.Two = GetCommonResource_CardLabelUis(ui:GetChild("Two"))
  uis.Three = GetCommonResource_CardLabelUis(ui:GetChild("Three"))
  uis.DetailedContentList = ui:GetChild("DetailedContentList")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


