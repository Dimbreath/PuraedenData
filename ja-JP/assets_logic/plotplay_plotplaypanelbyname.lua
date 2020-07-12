-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("PlotPlay_CharacterLoader01ByName")
require("PlotPlay_TalkWordByName")
require("PlotPlay_AutoByName")
require("PlotPlay_MenuPopOutWindowByName")
require("PlotPlay_CutByName")
require("PlotPlay_PlotPlayStarByName")
GetPlotPlay_PlotPlayPanelUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.backsceneLoader = ui:GetChild("backsceneLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.CardShow_01_Grp = GetPlotPlay_CharacterLoader01Uis(ui:GetChild("CardShow_01_Grp"))
  uis.CardShow_02_Grp = GetPlotPlay_CharacterLoader01Uis(ui:GetChild("CardShow_02_Grp"))
  uis.CardShow_03_Grp = GetPlotPlay_CharacterLoader01Uis(ui:GetChild("CardShow_03_Grp"))
  uis.CardShow_04_Grp = GetPlotPlay_CharacterLoader01Uis(ui:GetChild("CardShow_04_Grp"))
  uis.CardShow_05_Grp = GetPlotPlay_CharacterLoader01Uis(ui:GetChild("CardShow_05_Grp"))
  uis.TalkWordGrp = GetPlotPlay_TalkWordUis(ui:GetChild("TalkWordGrp"))
  uis.Auto = GetPlotPlay_AutoUis(ui:GetChild("Auto"))
  uis.BlankBtn = ui:GetChild("BlankBtn")
  uis.NextBtn = ui:GetChild("NextBtn")
  uis.Live2DBtn = ui:GetChild("Live2DBtn")
  uis.MenuBtn = ui:GetChild("MenuBtn")
  uis.MenuPopOutWindow_01_Grp = GetPlotPlay_MenuPopOutWindowUis(ui:GetChild("MenuPopOutWindow_01_Grp"))
  uis.ChoiceList = ui:GetChild("ChoiceList")
  uis.Mask_02_Image = ui:GetChild("Mask_02_Image")
  uis.Mask_03_Image = ui:GetChild("Mask_03_Image")
  uis.CutGrp = GetPlotPlay_CutUis(ui:GetChild("CutGrp"))
  uis.PlotPlayStarGrp = GetPlotPlay_PlotPlayStarUis(ui:GetChild("PlotPlayStarGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


