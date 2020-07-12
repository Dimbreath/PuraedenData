-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
require("CommonResource_NewCompByName")
GetCommonResource_EquiptIconUis = function(ui, ...)
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
  uis.UnAppraisalImage = ui:GetChild("UnAppraisalImage")
  uis.LockImage = ui:GetChild("LockImage")
  uis.ChoiceBtn = ui:GetChild("ChoiceBtn")
  uis.NewCompGrp = GetCommonResource_NewCompUis(ui:GetChild("NewCompGrp"))
  uis.DropLcokImage = ui:GetChild("DropLcokImage")
  uis.StarList = ui:GetChild("StarList")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.c4Ctr = ui:GetController("c4")
  uis.c5Ctr = ui:GetController("c5")
  uis.c6Ctr = ui:GetController("c6")
  uis.root = ui
  return uis
end


