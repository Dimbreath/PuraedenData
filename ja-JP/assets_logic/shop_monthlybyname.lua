-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_Monthly_1ByName")
require("Shop_Monthly_2ByName")
GetShop_MonthlyUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n0 = GetShop_Monthly_1Uis(ui:GetChild("n0"))
  uis.n1 = GetShop_Monthly_2Uis(ui:GetChild("n1"))
  uis.root = ui
  return uis
end


