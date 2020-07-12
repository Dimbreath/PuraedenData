-- params : ...
-- function num : 0 , upvalues : _ENV
require("Activity_ActivityContentByName")
require("CommonResource_AssetStripByName")
GetActivity_ActivityMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.ActivityContent = GetActivity_ActivityContentUis(ui:GetChild("ActivityContent"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.LineImage = ui:GetChild("LineImage")
  uis.ButtonList = ui:GetChild("ButtonList")
  uis.root = ui
  return uis
end


