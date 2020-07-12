-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("HandBook_CardPlotHeadListByName")
GetHandBook_CardPlotUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.CardPlotHeadList = GetHandBook_CardPlotHeadListUis(ui:GetChild("CardPlotHeadList"))
  uis.root = ui
  return uis
end


