-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("Battle_GuildBossInfoByName")
require("Battle_GuildBossTipsByName")
GetBattle_RewardUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ShowLoader = ui:GetChild("ShowLoader")
  uis.RewardImage = ui:GetChild("RewardImage")
  uis.RewardImage = ui:GetChild("RewardImage")
  uis.RewardImage = ui:GetChild("RewardImage")
  uis.RewardImage = GetCommonResource_Line_04Uis(ui:GetChild("RewardImage"))
  uis.Reward_01_Txt = ui:GetChild("Reward_01_Txt")
  uis.ItemList = ui:GetChild("ItemList")
  uis.ConfirmBtn = ui:GetChild("ConfirmBtn")
  uis.NextBtn = ui:GetChild("NextBtn")
  uis.DateBtn = ui:GetChild("DateBtn")
  uis.LvTxt = ui:GetChild("LvTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.ExperienceProgressBar = ui:GetChild("ExperienceProgressBar")
  uis.HurtProgressBar = ui:GetChild("HurtProgressBar")
  uis.HurtTxt = ui:GetChild("HurtTxt")
  uis.ExpNumberTxt = ui:GetChild("ExpNumberTxt")
  uis.TowerTxt = ui:GetChild("TowerTxt")
  uis.TowerLuckTxt = ui:GetChild("TowerLuckTxt")
  uis.GuildBossInfo = GetBattle_GuildBossInfoUis(ui:GetChild("GuildBossInfo"))
  uis.GuildBossTips = GetBattle_GuildBossTipsUis(ui:GetChild("GuildBossTips"))
  uis.FailWordTxt = ui:GetChild("FailWordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


