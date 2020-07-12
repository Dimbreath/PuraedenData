-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CommonResource_ResultImageByName")
require("Talent_TitleWord_BByName")
GetTalent_AttributeUp_BUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.RedImage = ui:GetChild("RedImage")
  uis.ResultImageGrp = GetCommonResource_ResultImageUis(ui:GetChild("ResultImageGrp"))
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.Decorate_06_Image = ui:GetChild("Decorate_06_Image")
  uis.Decorate_07_Image = ui:GetChild("Decorate_07_Image")
  uis.Decorate_08_Image = ui:GetChild("Decorate_08_Image")
  uis.Decorate_09_Image = ui:GetChild("Decorate_09_Image")
  uis.Decorate_10_Image = ui:GetChild("Decorate_10_Image")
  uis.TitleWord_B1_Grp = GetTalent_TitleWord_BUis(ui:GetChild("TitleWord_B1_Grp"))
  uis.Decorate_13_Image = ui:GetChild("Decorate_13_Image")
  uis.Decorate_14_Image = ui:GetChild("Decorate_14_Image")
  uis.Decorate_15_Image = ui:GetChild("Decorate_15_Image")
  uis.Decorate_16_Image = ui:GetChild("Decorate_16_Image")
  uis.TitleWord_B2_Grp = GetTalent_TitleWord_BUis(ui:GetChild("TitleWord_B2_Grp"))
  uis.Decorate_17_Image = ui:GetChild("Decorate_17_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.PowerImage = ui:GetChild("PowerImage")
  uis.PowerNumberTxt = ui:GetChild("PowerNumberTxt")
  uis.TalentSkillList = ui:GetChild("TalentSkillList")
  uis.AttribteList = ui:GetChild("AttribteList")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


