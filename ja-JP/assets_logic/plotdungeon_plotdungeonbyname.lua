-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotDungeon_MapByName")
require("PlotDungeon_ScrollByName")
GetPlotDungeon_PlotDungeonUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.MapGrp = GetPlotDungeon_MapUis(ui:GetChild("MapGrp"))
  uis.Scroll = GetPlotDungeon_ScrollUis(ui:GetChild("Scroll"))
  uis.root = ui
  return uis
end


