-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Guild_MainInformationByName")
require("Guild_GuildManageContentByName")
GetGuild_GuildManageUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.MainInformationGrp = GetGuild_MainInformationUis(ui:GetChild("MainInformationGrp"))
  uis.GuildManageContentGrp = GetGuild_GuildManageContentUis(ui:GetChild("GuildManageContentGrp"))
  uis.root = ui
  return uis
end


