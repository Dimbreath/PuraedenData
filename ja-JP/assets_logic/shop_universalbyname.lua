-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_Universal_1ByName")
require("Shop_Universal_2ByName")
require("Shop_Universal_3ByName")
GetShop_UniversalUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n0 = GetShop_Universal_1Uis(ui:GetChild("n0"))
  uis.n1 = GetShop_Universal_2Uis(ui:GetChild("n1"))
  uis.n2 = GetShop_Universal_3Uis(ui:GetChild("n2"))
  uis.root = ui
  return uis
end


