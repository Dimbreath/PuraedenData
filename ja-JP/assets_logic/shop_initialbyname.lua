-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_Initial_1ByName")
require("Shop_Initial_2ByName")
GetShop_InitialUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n0 = GetShop_Initial_1Uis(ui:GetChild("n0"))
  uis.n1 = GetShop_Initial_2Uis(ui:GetChild("n1"))
  uis.root = ui
  return uis
end


