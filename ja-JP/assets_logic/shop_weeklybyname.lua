-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_Weekly_1ByName")
require("Shop_Weekly_2ByName")
require("Shop_Weekly_3ByName")
require("Shop_Weekly_4ByName")
GetShop_WeeklyUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n0 = GetShop_Weekly_1Uis(ui:GetChild("n0"))
  uis.n1 = GetShop_Weekly_2Uis(ui:GetChild("n1"))
  uis.n2 = GetShop_Weekly_3Uis(ui:GetChild("n2"))
  uis.n3 = GetShop_Weekly_4Uis(ui:GetChild("n3"))
  uis.root = ui
  return uis
end


