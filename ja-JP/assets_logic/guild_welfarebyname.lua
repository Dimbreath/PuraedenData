-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_WelfareContentByName")
require("CommonResource_AssetStripByName")
GetGuild_WelfareUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.WelfareContent = GetGuild_WelfareContentUis(ui:GetChild("WelfareContent"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.RankingBtn = ui:GetChild("RankingBtn")
  uis.root = ui
  return uis
end


