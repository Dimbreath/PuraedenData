-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_DoubleDiamond_1ByName")
GetShop_DoubleDiamondUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n0 = GetShop_DoubleDiamond_1Uis(ui:GetChild("n0"))
  uis.root = ui
  return uis
end


