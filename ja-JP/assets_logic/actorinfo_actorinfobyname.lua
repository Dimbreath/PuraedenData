-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("ActorInfo_InfoAssemblyByName")
GetActorInfo_ActorInfoUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackImage = ui:GetChild("BackImage")
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.PictureLoader = ui:GetChild("PictureLoader")
  uis.BackImage = ui:GetChild("BackImage")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.InfoAssemblyGrp = GetActorInfo_InfoAssemblyUis(ui:GetChild("InfoAssemblyGrp"))
  uis.root = ui
  return uis
end


