-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_BuildEffect_BByName")
GetGuild_BuildEffect_AUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Effect_01_Grp = GetGuild_BuildEffect_BUis(ui:GetChild("Effect_01_Grp"))
  uis.Effect_02_Loader = ui:GetChild("Effect_02_Loader")
  uis.root = ui
  return uis
end


