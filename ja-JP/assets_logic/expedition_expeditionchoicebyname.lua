-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Expedition_ChoiceTipsByName")
GetExpedition_ExpeditionChoiceUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.OneImage = ui:GetChild("OneImage")
  uis.TwoImage = ui:GetChild("TwoImage")
  uis.ThreeImage = ui:GetChild("ThreeImage")
  uis.EffectLoader = ui:GetChild("EffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.ChoiceTips = GetExpedition_ChoiceTipsUis(ui:GetChild("ChoiceTips"))
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


