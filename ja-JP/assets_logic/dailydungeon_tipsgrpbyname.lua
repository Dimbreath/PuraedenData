-- params : ...
-- function num : 0 , upvalues : _ENV
require("DailyDungeon_ChoiceBgByName")
require("DailyDungeon_ChoiceCardByName")
GetDailyDungeon_TipsGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChoiceBg = GetDailyDungeon_ChoiceBgUis(ui:GetChild("ChoiceBg"))
  uis.ChoiceCard = GetDailyDungeon_ChoiceCardUis(ui:GetChild("ChoiceCard"))
  uis.NumberImage = ui:GetChild("NumberImage")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.LockImage = ui:GetChild("LockImage")
  uis.LockImage = ui:GetChild("LockImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


