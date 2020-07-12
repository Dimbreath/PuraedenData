-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_RewardA_1ByName")
require("Shop_RewardA_2ByName")
require("Shop_RewardA_3ByName")
require("Shop_RewardA_4ByName")
GetShop_RewardAUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n0 = GetShop_RewardA_1Uis(ui:GetChild("n0"))
  uis.n1 = GetShop_RewardA_2Uis(ui:GetChild("n1"))
  uis.n2 = GetShop_RewardA_3Uis(ui:GetChild("n2"))
  uis.n3 = GetShop_RewardA_4Uis(ui:GetChild("n3"))
  uis.root = ui
  return uis
end


