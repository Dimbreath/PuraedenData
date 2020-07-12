-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_BGGroupByName")
require("Talent_SkillListByName")
require("Talent_AttributeUpByName")
GetTalent_InnerUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BGGroup = GetTalent_BGGroupUis(ui:GetChild("BGGroup"))
  uis.AnimationLoader = ui:GetChild("AnimationLoader")
  uis.AGGroup = GetTalent_BGGroupUis(ui:GetChild("AGGroup"))
  uis.SkillList = GetTalent_SkillListUis(ui:GetChild("SkillList"))
  uis.AttributeUp = GetTalent_AttributeUpUis(ui:GetChild("AttributeUp"))
  uis.root = ui
  return uis
end


