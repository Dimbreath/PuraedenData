-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_JournalUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.Word_02_Txt = ui:GetChild("Word_02_Txt")
  uis.Word_03_Txt = ui:GetChild("Word_03_Txt")
  uis.JournalWordList = ui:GetChild("JournalWordList")
  uis.Choice_01_Btn = ui:GetChild("Choice_01_Btn")
  uis.Choice_02_Btn = ui:GetChild("Choice_02_Btn")
  uis.Choice_01_Txt = ui:GetChild("Choice_01_Txt")
  uis.Choice_02_Txt = ui:GetChild("Choice_02_Txt")
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.BattleTxt = ui:GetChild("BattleTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


