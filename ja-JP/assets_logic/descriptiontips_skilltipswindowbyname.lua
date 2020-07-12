-- params : ...
-- function num : 0 , upvalues : _ENV
require("DescriptionTips_SkillTipsByName")
GetDescriptionTips_SkillTipsWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.SkillTipsGrp = GetDescriptionTips_SkillTipsUis(ui:GetChild("SkillTipsGrp"))
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


