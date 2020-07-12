-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventure_MiddleCompUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ExperimentIconBtn = ui:GetChild("ExperimentIconBtn")
  uis.MapWorkshopIconBtn = ui:GetChild("MapWorkshopIconBtn")
  uis.ExpeditionIconBtn = ui:GetChild("ExpeditionIconBtn")
  uis.AdventureIconBtn = ui:GetChild("AdventureIconBtn")
  uis.ArenaIconBtn = ui:GetChild("ArenaIconBtn")
  uis.HeroBtn = ui:GetChild("HeroBtn")
  uis.RichIconBtn = ui:GetChild("RichIconBtn")
  uis.root = ui
  return uis
end


