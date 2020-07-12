-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
require("CommonResource_RedDollByName")
GetHandBook_IntimacyHeadUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChoiceHeadGrp = GetCommonResource_FrameEffUis(ui:GetChild("ChoiceHeadGrp"))
  uis.BackBlueImage = ui:GetChild("BackBlueImage")
  uis.BackPurpleImage = ui:GetChild("BackPurpleImage")
  uis.BackOrangeImage = ui:GetChild("BackOrangeImage")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.QualityBlueImage = ui:GetChild("QualityBlueImage")
  uis.QualityPurpleImage = ui:GetChild("QualityPurpleImage")
  uis.QualityOrangeImage = ui:GetChild("QualityOrangeImage")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


