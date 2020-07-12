-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivity_SignItemUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ItemLoader = ui:GetChild("ItemLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.OrderTxt = ui:GetChild("OrderTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


