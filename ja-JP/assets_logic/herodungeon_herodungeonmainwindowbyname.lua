-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
GetHeroDungeon_HeroDungeonMainWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.HeroPlotMapList = ui:GetChild("HeroPlotMapList")
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.SweepBtn = ui:GetChild("SweepBtn")
  uis.RewardBtn = ui:GetChild("RewardBtn")
  uis.NameImage = ui:GetChild("NameImage")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NameGrp = ui:GetChild("NameGrp")
  uis.root = ui
  return uis
end


