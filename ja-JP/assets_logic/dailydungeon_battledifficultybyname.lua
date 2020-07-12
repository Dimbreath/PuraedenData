-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
GetDailyDungeon_BattleDifficultyUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.LevelList = ui:GetChild("LevelList")
  uis.SkipFormationTxt = ui:GetChild("SkipFormationTxt")
  uis.BuffWordTxt = ui:GetChild("BuffWordTxt")
  uis.SkipFormationBtn = ui:GetChild("SkipFormationBtn")
  uis.SweepBtn = ui:GetChild("SweepBtn")
  uis.root = ui
  return uis
end


