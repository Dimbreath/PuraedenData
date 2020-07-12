-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_SkillByName")
GetTalent_SkillListUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.NumberProgressBar = ui:GetChild("NumberProgressBar")
  uis.Skill_001 = GetTalent_SkillUis(ui:GetChild("Skill_001"))
  uis.Skill_002 = GetTalent_SkillUis(ui:GetChild("Skill_002"))
  uis.Skill_003 = GetTalent_SkillUis(ui:GetChild("Skill_003"))
  uis.Skill_004 = GetTalent_SkillUis(ui:GetChild("Skill_004"))
  uis.Skill_005 = GetTalent_SkillUis(ui:GetChild("Skill_005"))
  uis.Skill_006 = GetTalent_SkillUis(ui:GetChild("Skill_006"))
  uis.Skill_007 = GetTalent_SkillUis(ui:GetChild("Skill_007"))
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.NowTxt = ui:GetChild("NowTxt")
  uis.MaxTxt = ui:GetChild("MaxTxt")
  uis.root = ui
  return uis
end


