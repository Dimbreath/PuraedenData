-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_GuildIconByName")
require("Guild_MainTipsByName")
require("Guild_ContentByName")
GetGuild_MainInformationUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.GuildIconGrp = GetGuild_GuildIconUis(ui:GetChild("GuildIconGrp"))
  uis.GuildNameTxt = ui:GetChild("GuildNameTxt")
  uis.GuildNameBtn = ui:GetChild("GuildNameBtn")
  uis.LvTxt = ui:GetChild("LvTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.ExpTxt = ui:GetChild("ExpTxt")
  uis.DetailsBtn = ui:GetChild("DetailsBtn")
  uis.ActiveGrp = GetGuild_MainTipsUis(ui:GetChild("ActiveGrp"))
  uis.BattleTxt = GetGuild_MainTipsUis(ui:GetChild("BattleTxt"))
  uis.BossGrp = GetGuild_MainTipsUis(ui:GetChild("BossGrp"))
  uis.NumberTxt = GetGuild_MainTipsUis(ui:GetChild("NumberTxt"))
  uis.NoticeList = ui:GetChild("NoticeList")
  uis.OutBtn = ui:GetChild("OutBtn")
  uis.ContentGrp = GetGuild_ContentUis(ui:GetChild("ContentGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


