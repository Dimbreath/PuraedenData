-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_EffectByName")
GetTalent_TalentSkillUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.EffectGrp = GetTalent_EffectUis(ui:GetChild("EffectGrp"))
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


