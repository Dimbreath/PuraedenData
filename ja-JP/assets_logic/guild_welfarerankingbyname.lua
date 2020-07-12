-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Guild_TalkByName")
require("Guild_RankingTipsByName")
GetGuild_WelfareRankingUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.CardList = ui:GetChild("CardList")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.TalkGrp = GetGuild_TalkUis(ui:GetChild("TalkGrp"))
  uis.OneselfGrp = GetGuild_RankingTipsUis(ui:GetChild("OneselfGrp"))
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


