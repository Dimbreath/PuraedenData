-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_TaroResultByName")
require("AdventureGame_TaroRewardByName")
GetAdventureGame_TaroResultCombineUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TaroResult = GetAdventureGame_TaroResultUis(ui:GetChild("TaroResult"))
  uis.TaroReward = GetAdventureGame_TaroRewardUis(ui:GetChild("TaroReward"))
  uis.root = ui
  return uis
end


