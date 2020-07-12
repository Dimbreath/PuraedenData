-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("AdventureGame_SceneCutMoveByName")
GetAdventureGame_AdventureGameUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.MapLoader = ui:GetChild("MapLoader")
  uis.ShadowImage = ui:GetChild("ShadowImage")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.EventBtn = ui:GetChild("EventBtn")
  uis.SceneCutMove = GetAdventureGame_SceneCutMoveUis(ui:GetChild("SceneCutMove"))
  uis.TenTimeBtn = ui:GetChild("TenTimeBtn")
  uis.OnceBtn = ui:GetChild("OnceBtn")
  uis.ControlBtn = ui:GetChild("ControlBtn")
  uis.BuildingBtn = ui:GetChild("BuildingBtn")
  uis.TaroBtn = ui:GetChild("TaroBtn")
  uis.VowBtn = ui:GetChild("VowBtn")
  uis.ThemeCardBtn = ui:GetChild("ThemeCardBtn")
  uis.root = ui
  return uis
end


