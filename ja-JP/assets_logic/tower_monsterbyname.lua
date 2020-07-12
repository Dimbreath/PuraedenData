-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CommonResource_AssetStripByName")
require("CommonResource_Line_04ByName")
require("Tower_FormationByName")
GetTower_MonsterUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Line_04Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.MonsterNameTxt = ui:GetChild("MonsterNameTxt")
  uis.LabelList = ui:GetChild("LabelList")
  uis.AttackList = ui:GetChild("AttackList")
  uis.LineupTxt = ui:GetChild("LineupTxt")
  uis.LineupWordTxt = ui:GetChild("LineupWordTxt")
  uis.FormationGrp = GetTower_FormationUis(ui:GetChild("FormationGrp"))
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.WaveImage = ui:GetChild("WaveImage")
  uis.WaveTxt = ui:GetChild("WaveTxt")
  uis.WaveList = ui:GetChild("WaveList")
  uis.LayerList = ui:GetChild("LayerList")
  uis.root = ui
  return uis
end


