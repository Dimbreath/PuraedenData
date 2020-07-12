-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
GetCommonResource_ItemFrameUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.FrameEffGrp = GetCommonResource_FrameEffUis(ui:GetChild("FrameEffGrp"))
  uis.BackWhiteImage = ui:GetChild("BackWhiteImage")
  uis.BackGreenImage = ui:GetChild("BackGreenImage")
  uis.BackBlueImage = ui:GetChild("BackBlueImage")
  uis.BackPurpleImage = ui:GetChild("BackPurpleImage")
  uis.BackOrangeImage = ui:GetChild("BackOrangeImage")
  uis.BackRedImage = ui:GetChild("BackRedImage")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.QualityWhiteImage = ui:GetChild("QualityWhiteImage")
  uis.QualityGreenImage = ui:GetChild("QualityGreenImage")
  uis.QualityBlueImage = ui:GetChild("QualityBlueImage")
  uis.QualityPurpleImage = ui:GetChild("QualityPurpleImage")
  uis.QualityOrangeImage = ui:GetChild("QualityOrangeImage")
  uis.QualityRedImage = ui:GetChild("QualityRedImage")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.GetImage = ui:GetChild("GetImage")
  uis.FirstPassImage = ui:GetChild("FirstPassImage")
  uis.QualityCtr = ui:GetController("Quality")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


