-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_StarImageByName")
require("CommonResource_SkillFrameByName")
GetDescriptionTips_SkillTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.StarImage = GetCommonResource_StarImageUis(ui:GetChild("StarImage"))
  uis.TipsImage = ui:GetChild("TipsImage")
  uis.SkillFrameGrp = GetCommonResource_SkillFrameUis(ui:GetChild("SkillFrameGrp"))
  uis.SkillNameTxt = ui:GetChild("SkillNameTxt")
  uis.SkillLevelTxt = ui:GetChild("SkillLevelTxt")
  uis.SkillTypeTxt = ui:GetChild("SkillTypeTxt")
  uis.OpenConditionTxt = ui:GetChild("OpenConditionTxt")
  uis.SkillWordTxt = ui:GetChild("SkillWordTxt")
  uis.SkillTipsGrp = ui:GetChild("SkillTipsGrp")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


