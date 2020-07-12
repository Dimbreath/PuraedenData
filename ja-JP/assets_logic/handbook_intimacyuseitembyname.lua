-- params : ...
-- function num : 0 , upvalues : _ENV
GetHandBook_IntimacyUseItemUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.PlusImage = ui:GetChild("PlusImage")
  uis.limitNumberTxt = ui:GetChild("limitNumberTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.ItemOneTxt = ui:GetChild("ItemOneTxt")
  uis.Item_01_Grp = ui:GetChild("Item_01_Grp")
  uis.root = ui
  return uis
end


