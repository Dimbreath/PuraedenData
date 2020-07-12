-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Guild_MainInformationByName")
require("Guild_Build_BByName")
GetGuild_BuildUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.MainInformationGrp = GetGuild_MainInformationUis(ui:GetChild("MainInformationGrp"))
  uis.Build_B_Grp = GetGuild_Build_BUis(ui:GetChild("Build_B_Grp"))
  uis.root = ui
  return uis
end


