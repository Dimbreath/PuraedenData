-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_ShopItemByName")
GetShop_ShopItemAnimationUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ShopItem = GetShop_ShopItemUis(ui:GetChild("ShopItem"))
  uis.root = ui
  return uis
end


