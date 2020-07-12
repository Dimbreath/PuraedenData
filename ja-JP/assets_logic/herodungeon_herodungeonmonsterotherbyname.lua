-- params : ...
-- function num : 0 , upvalues : _ENV
require("HeroDungeon_ChoiceByName")
GetHeroDungeon_HeroDungeonMonsterOtherUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CharacterLoader = ui:GetChild("CharacterLoader")
  uis.ChoiceGrp = GetHeroDungeon_ChoiceUis(ui:GetChild("ChoiceGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


