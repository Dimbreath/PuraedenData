-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_RewardB_1ByName")
require("Shop_RewardB_2ByName")
require("Shop_RewardB_3ByName")
GetShop_RewardBUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n4 = GetShop_RewardB_1Uis(ui:GetChild("n4"))
  uis.n5 = GetShop_RewardB_2Uis(ui:GetChild("n5"))
  uis.n6 = GetShop_RewardB_3Uis(ui:GetChild("n6"))
  uis.root = ui
  return uis
end


