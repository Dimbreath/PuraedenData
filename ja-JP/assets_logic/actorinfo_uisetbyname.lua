-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_SwitchByName")
GetActorInfo_UISetUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Content_01_Txt = ui:GetChild("Content_01_Txt")
  uis.Content_01_Grp = GetActorInfo_SwitchUis(ui:GetChild("Content_01_Grp"))
  uis.Content_02_Txt = ui:GetChild("Content_02_Txt")
  uis.Content_02_Grp = GetActorInfo_SwitchUis(ui:GetChild("Content_02_Grp"))
  uis.Content_03_Txt = ui:GetChild("Content_03_Txt")
  uis.Content_03_Grp = GetActorInfo_SwitchUis(ui:GetChild("Content_03_Grp"))
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.ExplainTxt = ui:GetChild("ExplainTxt")
  uis.root = ui
  return uis
end


