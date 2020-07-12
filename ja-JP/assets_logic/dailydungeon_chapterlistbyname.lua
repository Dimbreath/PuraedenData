-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("DailyDungeon_TipsGrpByName")
GetDailyDungeon_ChapterListUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.CardExpGrp = GetDailyDungeon_TipsGrpUis(ui:GetChild("CardExpGrp"))
  uis.GoldGrp = GetDailyDungeon_TipsGrpUis(ui:GetChild("GoldGrp"))
  uis.EquipMaterial = GetDailyDungeon_TipsGrpUis(ui:GetChild("EquipMaterial"))
  uis.ChapterListGrp = ui:GetChild("ChapterListGrp")
  uis.root = ui
  return uis
end


