-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("AdventureGame_VowRewardUpByName")
GetAdventureGame_VowRewardUpWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.VowRewardUpGrp = GetAdventureGame_VowRewardUpUis(ui:GetChild("VowRewardUpGrp"))
  uis.root = ui
  return uis
end


