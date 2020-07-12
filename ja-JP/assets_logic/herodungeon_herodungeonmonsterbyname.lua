-- params : ...
-- function num : 0 , upvalues : _ENV
require("HeroDungeon_ChoiceByName")
GetHeroDungeon_HeroDungeonMonsterUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_00_Image = ui:GetChild("Decorate_00_Image")
  uis.Btn = ui:GetChild("Btn")
  uis.CharacterLoader = ui:GetChild("CharacterLoader")
  uis.MonsterNumberTxt = ui:GetChild("MonsterNumberTxt")
  uis.ChoiceGrp = GetHeroDungeon_ChoiceUis(ui:GetChild("ChoiceGrp"))
  uis.ChallengeTimeTxt = ui:GetChild("ChallengeTimeTxt")
  uis.ChallengeNumberTxt = ui:GetChild("ChallengeNumberTxt")
  uis.BattelNumberGrp = ui:GetChild("BattelNumberGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


