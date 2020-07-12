-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
require("Tower_EncounterByName")
GetTower_EncounterWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAniB = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAniB"))
  uis.Encounter = GetTower_EncounterUis(ui:GetChild("Encounter"))
  uis.root = ui
  return uis
end


