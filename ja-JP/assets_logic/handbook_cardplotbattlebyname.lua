-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
GetHandBook_CardPlotBattleUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.MapList = ui:GetChild("MapList")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.CardPlotCGBtn = ui:GetChild("CardPlotCGBtn")
  uis.root = ui
  return uis
end


