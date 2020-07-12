-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Guild_MainInformationByName")
require("Guild_ChatByName")
GetGuild_GuildMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.BuildBtn = ui:GetChild("BuildBtn")
  uis.GuessBtn = ui:GetChild("GuessBtn")
  uis.InformationBtn = ui:GetChild("InformationBtn")
  uis.LuckyBagBtn = ui:GetChild("LuckyBagBtn")
  uis.MainInformationGrp = GetGuild_MainInformationUis(ui:GetChild("MainInformationGrp"))
  uis.ChatGrp = GetGuild_ChatUis(ui:GetChild("ChatGrp"))
  uis.root = ui
  return uis
end


