-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_SwitchByName")
GetActorInfo_MassageSetUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Content_01_Txt = ui:GetChild("Content_01_Txt")
  uis.Content_01_Grp = GetActorInfo_SwitchUis(ui:GetChild("Content_01_Grp"))
  uis.Content_02_Txt = ui:GetChild("Content_02_Txt")
  uis.Content_02_Grp = GetActorInfo_SwitchUis(ui:GetChild("Content_02_Grp"))
  uis.root = ui
  return uis
end


