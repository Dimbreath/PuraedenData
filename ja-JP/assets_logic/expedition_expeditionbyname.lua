-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Expedition_GetBuffByName")
GetExpedition_ExpeditionUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Map_001_List = ui:GetChild("Map_001_List")
  uis.Map_002_List = ui:GetChild("Map_002_List")
  uis.CloudLoader = ui:GetChild("CloudLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.GetBuff = GetExpedition_GetBuffUis(ui:GetChild("GetBuff"))
  uis.ShopBtn = ui:GetChild("ShopBtn")
  uis.root = ui
  return uis
end


