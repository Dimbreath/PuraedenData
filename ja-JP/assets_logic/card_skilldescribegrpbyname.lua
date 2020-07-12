-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_SkillDescribeEffectGrpByName")
require("CommonResource_SkillFrameByName")
require("Card_SkillLevelUpByName")
GetCard_SkillDescribeGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Detailmeassgeback_01_Image = ui:GetChild("Detailmeassgeback_01_Image")
  uis.Icon_01_Loader = ui:GetChild("Icon_01_Loader")
  uis.GoldImage = ui:GetChild("GoldImage")
  uis.Number_01_Txt = ui:GetChild("Number_01_Txt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.LevelEffectTxt = ui:GetChild("LevelEffectTxt")
  uis.SkillDescribeEffectGrp = GetCard_SkillDescribeEffectGrpUis(ui:GetChild("SkillDescribeEffectGrp"))
  uis.DescribeTxt = ui:GetChild("DescribeTxt")
  uis.SkipBtn = ui:GetChild("SkipBtn")
  uis.SkillFrameGrp = GetCommonResource_SkillFrameUis(ui:GetChild("SkillFrameGrp"))
  uis.MaxTipsImage = ui:GetChild("MaxTipsImage")
  uis.StageNumberTxt = ui:GetChild("StageNumberTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.SkillDescribeGrp = GetCard_SkillLevelUpUis(ui:GetChild("SkillDescribeGrp"))
  uis.SkillDescribeGrp = ui:GetChild("SkillDescribeGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


