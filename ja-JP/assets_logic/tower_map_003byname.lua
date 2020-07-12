-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_Layer_003ByName")
require("Tower_LayerNumberByName")
require("Tower_Line_1ByName")
require("Tower_Battle_01ByName")
require("Tower_Line_2ByName")
require("Tower_Battle_02ByName")
require("Tower_Line_3ByName")
GetTower_Map_003Uis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Layer = GetTower_Layer_003Uis(ui:GetChild("Layer"))
  uis.LayerNumber = GetTower_LayerNumberUis(ui:GetChild("LayerNumber"))
  uis.Line_01 = GetTower_Line_1Uis(ui:GetChild("Line_01"))
  uis.Battle_01 = GetTower_Battle_01Uis(ui:GetChild("Battle_01"))
  uis.Line_02 = GetTower_Line_1Uis(ui:GetChild("Line_02"))
  uis.Battle_02 = GetTower_Battle_01Uis(ui:GetChild("Battle_02"))
  uis.Line_03 = GetTower_Line_2Uis(ui:GetChild("Line_03"))
  uis.Battle_03 = GetTower_Battle_02Uis(ui:GetChild("Battle_03"))
  uis.Line_04 = GetTower_Line_3Uis(ui:GetChild("Line_04"))
  uis.Battle_04 = GetTower_Battle_02Uis(ui:GetChild("Battle_04"))
  uis.LockImage = ui:GetChild("LockImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


