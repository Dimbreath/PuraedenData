-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Card_CardHeadListCmpByName")
GetCard_CardListUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.AllBtn = ui:GetChild("AllBtn")
  uis.ATKBtn = ui:GetChild("ATKBtn")
  uis.DEFBtn = ui:GetChild("DEFBtn")
  uis.ASSBtn = ui:GetChild("ASSBtn")
  uis.CardHeadListCmp = GetCard_CardHeadListCmpUis(ui:GetChild("CardHeadListCmp"))
  uis.InfoGrp = ui:GetChild("InfoGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


