-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_BlackMaskByName")
require("CommonResource_AssetStripByName")
GetTower_TowerUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackMaskGrp = GetTower_BlackMaskUis(ui:GetChild("BlackMaskGrp"))
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.LayerList = ui:GetChild("LayerList")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.MonsterBtn = ui:GetChild("MonsterBtn")
  uis.BattleBtn = ui:GetChild("BattleBtn")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.root = ui
  return uis
end


