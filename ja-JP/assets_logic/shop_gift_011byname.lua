-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_GiftTipsByName")
GetShop_Gift_011Uis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.GiftTips = GetShop_GiftTipsUis(ui:GetChild("GiftTips"))
  uis.LockImage = ui:GetChild("LockImage")
  uis.LockImage = ui:GetChild("LockImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.LockCtr = ui:GetController("Lock")
  uis.root = ui
  return uis
end


