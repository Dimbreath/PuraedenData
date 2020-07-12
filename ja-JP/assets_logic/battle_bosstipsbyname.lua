-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
GetBattle_BossTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Type_01_Txt = ui:GetChild("Type_01_Txt")
  uis.Type_02_Txt = ui:GetChild("Type_02_Txt")
  uis.StoryTxt = ui:GetChild("StoryTxt")
  uis.SkillTxt = ui:GetChild("SkillTxt")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


