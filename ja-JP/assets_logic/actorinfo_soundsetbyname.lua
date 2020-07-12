-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_SoundControlByName")
GetActorInfo_SoundSetUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.SoundControl_01_Grp = GetActorInfo_SoundControlUis(ui:GetChild("SoundControl_01_Grp"))
  uis.SoundControl_02_Grp = GetActorInfo_SoundControlUis(ui:GetChild("SoundControl_02_Grp"))
  uis.SoundControl_03_Grp = GetActorInfo_SoundControlUis(ui:GetChild("SoundControl_03_Grp"))
  uis.root = ui
  return uis
end


