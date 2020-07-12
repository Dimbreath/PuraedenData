-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_AttackOrderByName")
require("Battle_TalkByName")
GetBattle_BattleCharacterBloodUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HpYellowProgressBar = ui:GetChild("HpYellowProgressBar")
  uis.HpGreenProgressBar = ui:GetChild("HpGreenProgressBar")
  uis.RageProgressBar = ui:GetChild("RageProgressBar")
  uis.DefenseProgressBar = ui:GetChild("DefenseProgressBar")
  uis.HpEliteProgressBar = ui:GetChild("HpEliteProgressBar")
  uis.HpBossProgressBar = ui:GetChild("HpBossProgressBar")
  uis.AttackOrder = GetBattle_AttackOrderUis(ui:GetChild("AttackOrder"))
  uis.BuffIconList = ui:GetChild("BuffIconList")
  uis.PercentageTxt = ui:GetChild("PercentageTxt")
  uis.Talk = GetBattle_TalkUis(ui:GetChild("Talk"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


