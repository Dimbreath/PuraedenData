-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("HandBook_AttributeTipsByName")
GetHandBook_RelationUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.Relation_CardList = ui:GetChild("Relation_CardList")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.AttributeTipsGrp = GetHandBook_AttributeTipsUis(ui:GetChild("AttributeTipsGrp"))
  uis.OverviewBtn = ui:GetChild("OverviewBtn")
  uis.root = ui
  return uis
end


