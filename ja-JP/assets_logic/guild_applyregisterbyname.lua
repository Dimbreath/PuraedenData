-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Guild_RegisterByName")
require("Guild_ApplyByName")
GetGuild_ApplyRegisterUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.RegisterGrp = GetGuild_RegisterUis(ui:GetChild("RegisterGrp"))
  uis.ApplyGrp = GetGuild_ApplyUis(ui:GetChild("ApplyGrp"))
  uis.ApplyBtn = ui:GetChild("ApplyBtn")
  uis.RegisterBtn = ui:GetChild("RegisterBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


