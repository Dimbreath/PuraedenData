-- params : ...
-- function num : 0 , upvalues : _ENV
require("Share_InformationByName")
GetLottery_LotteryRewardUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.RewardList = ui:GetChild("RewardList")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.Information = GetShare_InformationUis(ui:GetChild("Information"))
  uis.root = ui
  return uis
end


