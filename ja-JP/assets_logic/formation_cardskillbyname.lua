-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_SkillFrameByName")
GetFormation_CardSkillUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.SkillFrameGrp = GetCommonResource_SkillFrameUis(ui:GetChild("SkillFrameGrp"))
  uis.CardWordTxt = ui:GetChild("CardWordTxt")
  uis.root = ui
  return uis
end


