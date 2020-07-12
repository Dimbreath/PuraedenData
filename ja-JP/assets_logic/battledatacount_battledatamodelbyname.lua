-- params : ...
-- function num : 0 , upvalues : _ENV
require("BattleDataCount_RecordBattleDataCardGrpByName")
GetBattleDataCount_BattleDataModelUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.MySelfTxt = ui:GetChild("MySelfTxt")
  uis.EnemyTxt = ui:GetChild("EnemyTxt")
  uis.MySelf_01_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("MySelf_01_Grp"))
  uis.MySelf_02_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("MySelf_02_Grp"))
  uis.MySelf_03_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("MySelf_03_Grp"))
  uis.MySelf_04_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("MySelf_04_Grp"))
  uis.MySelf_05_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("MySelf_05_Grp"))
  uis.MySelf_06_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("MySelf_06_Grp"))
  uis.MySelfGrp = ui:GetChild("MySelfGrp")
  uis.Enemy_01_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("Enemy_01_Grp"))
  uis.Enemy_02_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("Enemy_02_Grp"))
  uis.Enemy_03_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("Enemy_03_Grp"))
  uis.Enemy_04_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("Enemy_04_Grp"))
  uis.Enemy_05_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("Enemy_05_Grp"))
  uis.Enemy_06_Grp = GetBattleDataCount_RecordBattleDataCardGrpUis(ui:GetChild("Enemy_06_Grp"))
  uis.EnemyGrp = ui:GetChild("EnemyGrp")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


