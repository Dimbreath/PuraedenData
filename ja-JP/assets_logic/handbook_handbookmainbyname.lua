-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
GetHandBook_HandBookMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.IntimacyBtn = ui:GetChild("IntimacyBtn")
  uis.CardPlotBtn = ui:GetChild("CardPlotBtn")
  uis.AlbumBtn = ui:GetChild("AlbumBtn")
  uis.RelationBtn = ui:GetChild("RelationBtn")
  uis.StoryPlotBtn = ui:GetChild("StoryPlotBtn")
  uis.root = ui
  return uis
end


