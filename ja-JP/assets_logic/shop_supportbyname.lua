-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_Support_1ByName")
require("Shop_Support_2ByName")
require("Shop_Support_3ByName")
require("Shop_Support_4ByName")
require("Shop_Support_5ByName")
require("Shop_Support_6ByName")
require("Shop_Support_7ByName")
require("Shop_Support_8ByName")
GetShop_SupportUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n0 = GetShop_Support_1Uis(ui:GetChild("n0"))
  uis.n1 = GetShop_Support_2Uis(ui:GetChild("n1"))
  uis.n2 = GetShop_Support_3Uis(ui:GetChild("n2"))
  uis.n3 = GetShop_Support_4Uis(ui:GetChild("n3"))
  uis.n4 = GetShop_Support_5Uis(ui:GetChild("n4"))
  uis.n5 = GetShop_Support_6Uis(ui:GetChild("n5"))
  uis.n6 = GetShop_Support_7Uis(ui:GetChild("n6"))
  uis.n7 = GetShop_Support_8Uis(ui:GetChild("n7"))
  uis.root = ui
  return uis
end


