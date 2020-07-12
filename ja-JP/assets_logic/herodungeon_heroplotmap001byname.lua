-- params : ...
-- function num : 0 , upvalues : _ENV
require("HeroDungeon_Map001_1ByName")
require("HeroDungeon_HeroDungeonMonsterByName")
require("HeroDungeon_HeroDungeonMonsterOtherByName")
GetHeroDungeon_HeroPlotMap001Uis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Effect_1_Grp = GetHeroDungeon_Map001_1Uis(ui:GetChild("Effect_1_Grp"))
  uis.LineGrp = ui:GetChild("LineGrp")
  uis.Monster_01_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_01_Grp"))
  uis.Monster_02_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_02_Grp"))
  uis.Monster_03_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_03_Grp"))
  uis.Monster_04_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_04_Grp"))
  uis.Monster_05_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_05_Grp"))
  uis.Monster_06_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_06_Grp"))
  uis.Monster_07_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_07_Grp"))
  uis.Monster_08_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_08_Grp"))
  uis.Monster_09_Grp = GetHeroDungeon_HeroDungeonMonsterUis(ui:GetChild("Monster_09_Grp"))
  uis.Monster_10_Grp = GetHeroDungeon_HeroDungeonMonsterOtherUis(ui:GetChild("Monster_10_Grp"))
  uis.MonsterGrp = ui:GetChild("MonsterGrp")
  uis.root = ui
  return uis
end


