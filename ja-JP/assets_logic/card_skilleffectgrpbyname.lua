-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_SkillAllUpByName")
GetCard_SkillEffectGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.SkillList = ui:GetChild("SkillList")
  uis.SkillAllUp = GetCard_SkillAllUpUis(ui:GetChild("SkillAllUp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


