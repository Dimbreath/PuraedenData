-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("PlotDungeon_PlotDungeonByName")
require("CommonResource_Line_04ByName")
require("PlotDungeon_Message_BByName")
GetPlotDungeon_PlotPlayWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.PlotDungeonGrp = GetPlotDungeon_PlotDungeonUis(ui:GetChild("PlotDungeonGrp"))
  uis.BoxBtn = ui:GetChild("BoxBtn")
  uis.CGBtn = ui:GetChild("CGBtn")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.n38 = GetCommonResource_Line_04Uis(ui:GetChild("n38"))
  uis.StoryNumberTxt = ui:GetChild("StoryNumberTxt")
  uis.NameGrp = ui:GetChild("NameGrp")
  uis.Message_B = GetPlotDungeon_Message_BUis(ui:GetChild("Message_B"))
  uis.root = ui
  return uis
end


