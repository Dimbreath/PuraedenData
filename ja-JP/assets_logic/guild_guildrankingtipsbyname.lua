-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_GuildIconByName")
require("Guild_TipsInfo_01ByName")
require("Guild_TipsInfo_02ByName")
require("Guild_TipsInfo_03ByName")
GetGuild_GuildRankingTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.GuildIconGrp = GetGuild_GuildIconUis(ui:GetChild("GuildIconGrp"))
  uis.GuildLevelTxt = ui:GetChild("GuildLevelTxt")
  uis.GuildNameTxt = ui:GetChild("GuildNameTxt")
  uis.Ranking_01_Image = ui:GetChild("Ranking_01_Image")
  uis.FirstGrp = ui:GetChild("FirstGrp")
  uis.Ranking_02_Image = ui:GetChild("Ranking_02_Image")
  uis.SecondGrp = ui:GetChild("SecondGrp")
  uis.Ranking_03_Image = ui:GetChild("Ranking_03_Image")
  uis.ThirdGrp = ui:GetChild("ThirdGrp")
  uis.Ranking_04_Image = ui:GetChild("Ranking_04_Image")
  uis.Ranking_04_Txt = ui:GetChild("Ranking_04_Txt")
  uis.FouthGrp = ui:GetChild("FouthGrp")
  uis.TipsInfo_01_Grp = GetGuild_TipsInfo_01Uis(ui:GetChild("TipsInfo_01_Grp"))
  uis.TipsInfo_02_Grp = GetGuild_TipsInfo_02Uis(ui:GetChild("TipsInfo_02_Grp"))
  uis.TipsInfo_03_Grp = GetGuild_TipsInfo_03Uis(ui:GetChild("TipsInfo_03_Grp"))
  uis.MemberTxt = ui:GetChild("MemberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


