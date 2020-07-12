-- params : ...
-- function num : 0 , upvalues : _ENV
GetTalent_SkillUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.ChoiceImage = ui:GetChild("ChoiceImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


