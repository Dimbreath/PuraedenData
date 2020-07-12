-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
GetHandBook_StoryPlotUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.StoryPlotChapterList = ui:GetChild("StoryPlotChapterList")
  uis.DetailsList = ui:GetChild("DetailsList")
  uis.root = ui
  return uis
end


