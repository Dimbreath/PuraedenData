-- params : ...
-- function num : 0 , upvalues : _ENV
GetLottery_ItemUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ItemLoader = ui:GetChild("ItemLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


