-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("CommonResource_AssetStripByName")
require("ActivityDungeon_TimeByName")
GetActivityDungeon_ActivityMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.ExchangeBtn = ui:GetChild("ExchangeBtn")
  uis.PlotBtn = ui:GetChild("PlotBtn")
  uis.Time = GetActivityDungeon_TimeUis(ui:GetChild("Time"))
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.ChapterList = ui:GetChild("ChapterList")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.root = ui
  return uis
end


