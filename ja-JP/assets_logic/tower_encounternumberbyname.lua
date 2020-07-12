-- params : ...
-- function num : 0 , upvalues : _ENV
GetTower_EncounterNumberUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ArenaZudangback_01_Image = ui:GetChild("ArenaZudangback_01_Image")
  uis.ArenaNumber_01_Txt = ui:GetChild("ArenaNumber_01_Txt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.root = ui
  return uis
end


