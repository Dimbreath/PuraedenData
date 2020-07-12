-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Guild_GuildRankingTipsByName")
GetGuild_GuildRankingUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.OtherGuildList = ui:GetChild("OtherGuildList")
  uis.OneSelfGrp = GetGuild_GuildRankingTipsUis(ui:GetChild("OneSelfGrp"))
  uis.root = ui
  return uis
end


