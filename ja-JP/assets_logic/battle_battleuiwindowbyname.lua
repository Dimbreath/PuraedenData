-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_TotalWordEByName")
require("Battle_TotalWordPByName")
require("Battle_GuildBossIntegralByName")
require("Battle_BossBloodByName")
require("Battle_BattleCharctorCompByName")
require("Battle_PicShowByName")
require("Battle_ReversePicShowByName")
GetBattle_BattleUIWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.RightToTalDamage = GetBattle_TotalWordEUis(ui:GetChild("RightToTalDamage"))
  uis.LeftToTalDamage = GetBattle_TotalWordPUis(ui:GetChild("LeftToTalDamage"))
  uis.RoundImage = ui:GetChild("RoundImage")
  uis.RoundImage = ui:GetChild("RoundImage")
  uis.RoundNumTxt = ui:GetChild("RoundNumTxt")
  uis.RoundGrp = ui:GetChild("RoundGrp")
  uis.WaveImage = ui:GetChild("WaveImage")
  uis.WaveImage = ui:GetChild("WaveImage")
  uis.WaveTxt = ui:GetChild("WaveTxt")
  uis.WaveGrp = ui:GetChild("WaveGrp")
  uis.OrderBackLineImage = ui:GetChild("OrderBackLineImage")
  uis.GuildBossIntegral = GetBattle_GuildBossIntegralUis(ui:GetChild("GuildBossIntegral"))
  uis.SkipBtn = ui:GetChild("SkipBtn")
  uis.SettingBtn = ui:GetChild("SettingBtn")
  uis.AutoBtn = ui:GetChild("AutoBtn")
  uis.SpeedBtn = ui:GetChild("SpeedBtn")
  uis.StopBtn = ui:GetChild("StopBtn")
  uis.BtnGrp = ui:GetChild("BtnGrp")
  uis.BossImage = ui:GetChild("BossImage")
  uis.BossImage = ui:GetChild("BossImage")
  uis.BossBlood = GetBattle_BossBloodUis(ui:GetChild("BossBlood"))
  uis.BossNameTxt = ui:GetChild("BossNameTxt")
  uis.BossHeadCircleIconLoader = ui:GetChild("BossHeadCircleIconLoader")
  uis.BossBloodNumberTxt = ui:GetChild("BossBloodNumberTxt")
  uis.BossBloodGrp = ui:GetChild("BossBloodGrp")
  uis.LeftSkillTxt = ui:GetChild("LeftSkillTxt")
  uis.RightSkillTxt = ui:GetChild("RightSkillTxt")
  uis.SkillCard = GetBattle_BattleCharctorCompUis(ui:GetChild("SkillCard"))
  uis.OneSelfTxt = ui:GetChild("OneSelfTxt")
  uis.EnemyTxt = ui:GetChild("EnemyTxt")
  uis.PicShow = GetBattle_PicShowUis(ui:GetChild("PicShow"))
  uis.ReversePicShow = GetBattle_ReversePicShowUis(ui:GetChild("ReversePicShow"))
  uis.root = ui
  return uis
end


