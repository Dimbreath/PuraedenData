-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_CardTipsByName")
require("Battle_RewardByName")
require("Battle_FailTipsByName")
GetBattle_BattleFailUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.Card_01_Tips = GetBattle_CardTipsUis(ui:GetChild("Card_01_Tips"))
  uis.Card_02_Tips = GetBattle_CardTipsUis(ui:GetChild("Card_02_Tips"))
  uis.Card_03_Tips = GetBattle_CardTipsUis(ui:GetChild("Card_03_Tips"))
  uis.Card_04_Tips = GetBattle_CardTipsUis(ui:GetChild("Card_04_Tips"))
  uis.Card_05_Tips = GetBattle_CardTipsUis(ui:GetChild("Card_05_Tips"))
  uis.Card_06_Tips = GetBattle_CardTipsUis(ui:GetChild("Card_06_Tips"))
  uis.Decorate_00_Image = ui:GetChild("Decorate_00_Image")
  uis.RewardGrp = GetBattle_RewardUis(ui:GetChild("RewardGrp"))
  uis.FailTips = GetBattle_FailTipsUis(ui:GetChild("FailTips"))
  uis.ExpeditionImage = ui:GetChild("ExpeditionImage")
  uis.ExpeditionImage = ui:GetChild("ExpeditionImage")
  uis.ExpeditionImage = ui:GetChild("ExpeditionImage")
  uis.ExpeditionTxt = ui:GetChild("ExpeditionTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


