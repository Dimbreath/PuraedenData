-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_CardPositionByName")
GetTower_FormationUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Self_01_Grp = GetTower_CardPositionUis(ui:GetChild("Self_01_Grp"))
  uis.Self_02_Grp = GetTower_CardPositionUis(ui:GetChild("Self_02_Grp"))
  uis.Self_03_Grp = GetTower_CardPositionUis(ui:GetChild("Self_03_Grp"))
  uis.Self_04_Grp = GetTower_CardPositionUis(ui:GetChild("Self_04_Grp"))
  uis.Self_05_Grp = GetTower_CardPositionUis(ui:GetChild("Self_05_Grp"))
  uis.Self_06_Grp = GetTower_CardPositionUis(ui:GetChild("Self_06_Grp"))
  uis.Enemy_01_Grp = GetTower_CardPositionUis(ui:GetChild("Enemy_01_Grp"))
  uis.Enemy_02_Grp = GetTower_CardPositionUis(ui:GetChild("Enemy_02_Grp"))
  uis.Enemy_03_Grp = GetTower_CardPositionUis(ui:GetChild("Enemy_03_Grp"))
  uis.Enemy_04_Grp = GetTower_CardPositionUis(ui:GetChild("Enemy_04_Grp"))
  uis.Enemy_05_Grp = GetTower_CardPositionUis(ui:GetChild("Enemy_05_Grp"))
  uis.Enemy_06_Grp = GetTower_CardPositionUis(ui:GetChild("Enemy_06_Grp"))
  uis.root = ui
  return uis
end


