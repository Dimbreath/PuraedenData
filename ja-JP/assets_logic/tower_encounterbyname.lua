-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_EncounterPicByName")
require("Tower_EncounterNumberByName")
GetTower_EncounterUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Left = GetTower_EncounterPicUis(ui:GetChild("Left"))
  uis.LeftNumber = GetTower_EncounterNumberUis(ui:GetChild("LeftNumber"))
  uis.Right = GetTower_EncounterPicUis(ui:GetChild("Right"))
  uis.RightNumber = GetTower_EncounterNumberUis(ui:GetChild("RightNumber"))
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.BattleBtn = ui:GetChild("BattleBtn")
  uis.WhileBtn = ui:GetChild("WhileBtn")
  uis.RetreatBtn = ui:GetChild("RetreatBtn")
  uis.ALoader = ui:GetChild("ALoader")
  uis.root = ui
  return uis
end


