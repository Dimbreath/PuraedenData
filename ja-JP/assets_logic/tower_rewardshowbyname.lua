-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("Tower_BackImageByName")
require("Tower_BuffByName")
require("Tower_NumberByName")
require("Tower_RewardTipsByName")
GetTower_RewardShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n48 = GetCommonResource_Line_04Uis(ui:GetChild("n48"))
  uis.BackImageGrp = GetTower_BackImageUis(ui:GetChild("BackImageGrp"))
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.BuffGrp = GetTower_BuffUis(ui:GetChild("BuffGrp"))
  uis.Number_01_Grp = GetTower_NumberUis(ui:GetChild("Number_01_Grp"))
  uis.Number_02_Grp = GetTower_NumberUis(ui:GetChild("Number_02_Grp"))
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.BattleWordTxt = ui:GetChild("BattleWordTxt")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.SweepBtn = ui:GetChild("SweepBtn")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.BattleBtn = ui:GetChild("BattleBtn")
  uis.Reward_01_Tips = GetTower_RewardTipsUis(ui:GetChild("Reward_01_Tips"))
  uis.Reward_02_Tips = GetTower_RewardTipsUis(ui:GetChild("Reward_02_Tips"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


