-- params : ...
-- function num : 0 , upvalues : _ENV
require("DescriptionTips_DoubleRewardTipsByName")
GetDescriptionTips_DoubleRewardTipsWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DoubleRewardTips = GetDescriptionTips_DoubleRewardTipsUis(ui:GetChild("DoubleRewardTips"))
  uis.root = ui
  return uis
end


