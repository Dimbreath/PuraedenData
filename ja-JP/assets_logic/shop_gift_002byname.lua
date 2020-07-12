-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_GiftTipsByName")
require("CommonResource_RedDollByName")
GetShop_Gift_002Uis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.GiftTips = GetShop_GiftTipsUis(ui:GetChild("GiftTips"))
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.root = ui
  return uis
end


