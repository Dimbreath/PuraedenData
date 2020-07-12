-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_Daily_1ByName")
require("Shop_Daily_2ByName")
GetShop_DailyUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n0 = GetShop_Daily_1Uis(ui:GetChild("n0"))
  uis.n1 = GetShop_Daily_2Uis(ui:GetChild("n1"))
  uis.root = ui
  return uis
end


