-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_SkillFrameByName")
GetCardPop_SkillMessageUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.SkillFrameGrp = GetCommonResource_SkillFrameUis(ui:GetChild("SkillFrameGrp"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.root = ui
  return uis
end


