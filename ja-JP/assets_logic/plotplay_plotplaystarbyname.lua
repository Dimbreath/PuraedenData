-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotPlay_PlotPlayStarEffectByName")
require("PlotPlay_PlotPlayStarNameByName")
GetPlotPlay_PlotPlayStarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.n31 = GetPlotPlay_PlotPlayStarEffectUis(ui:GetChild("n31"))
  uis.ChapterTxt = ui:GetChild("ChapterTxt")
  uis.PlotPlayStarName = GetPlotPlay_PlotPlayStarNameUis(ui:GetChild("PlotPlayStarName"))
  uis.root = ui
  return uis
end


