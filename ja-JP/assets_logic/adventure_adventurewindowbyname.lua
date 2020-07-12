-- params : ...
-- function num : 0 , upvalues : _ENV
require("Adventure_BackCompByName")
require("Adventure_MiddleCompByName")
require("Adventure_NearCompByName")
require("CommonResource_AssetStripByName")
GetAdventure_AdventureWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackComp = GetAdventure_BackCompUis(ui:GetChild("BackComp"))
  uis.MiddleComp = GetAdventure_MiddleCompUis(ui:GetChild("MiddleComp"))
  uis.NearComp = GetAdventure_NearCompUis(ui:GetChild("NearComp"))
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.root = ui
  return uis
end


