-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("AdventureGame_VowRewardChoiceByName")
GetAdventureGame_VowRewardChoiceWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.VowRewardChoice = GetAdventureGame_VowRewardChoiceUis(ui:GetChild("VowRewardChoice"))
  uis.root = ui
  return uis
end


