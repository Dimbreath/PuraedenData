-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_GuildBossInfoUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BossHpProgressBar = ui:GetChild("BossHpProgressBar")
  uis.HpTxt = ui:GetChild("HpTxt")
  uis.HpNumberTxt = ui:GetChild("HpNumberTxt")
  uis.HurtTxt = ui:GetChild("HurtTxt")
  uis.HurtNumberTxt = ui:GetChild("HurtNumberTxt")
  uis.IntegralTxt = ui:GetChild("IntegralTxt")
  uis.IntegralNumberTxt = ui:GetChild("IntegralNumberTxt")
  uis.root = ui
  return uis
end


