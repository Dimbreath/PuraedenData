-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_BGGroupByName")
require("Talent_InnerByName")
require("Talent_OuterByName")
require("CommonResource_AssetStripByName")
GetTalent_TalentMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.BGGroup = GetTalent_BGGroupUis(ui:GetChild("BGGroup"))
  uis.Inner = GetTalent_InnerUis(ui:GetChild("Inner"))
  uis.Outer = GetTalent_OuterUis(ui:GetChild("Outer"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


