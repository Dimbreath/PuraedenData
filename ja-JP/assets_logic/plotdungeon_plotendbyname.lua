-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotDungeon_MagicByName")
GetPlotDungeon_PlotEndUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.n1 = GetPlotDungeon_MagicUis(ui:GetChild("n1"))
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


