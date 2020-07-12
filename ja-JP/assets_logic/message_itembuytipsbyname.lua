-- params : ...
-- function num : 0 , upvalues : _ENV
GetMessage_ItemBuyTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Image = ui:GetChild("Image")
  uis.ItemList = ui:GetChild("ItemList")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


