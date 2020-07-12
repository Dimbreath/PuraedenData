-- params : ...
-- function num : 0 , upvalues : _ENV
GetExpedition_ItemBuyUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.SpendLoader = ui:GetChild("SpendLoader")
  uis.SpendNumberTxt = ui:GetChild("SpendNumberTxt")
  uis.BuyNumberTxt = ui:GetChild("BuyNumberTxt")
  uis.BuyBtn = ui:GetChild("BuyBtn")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.IconNumberTxt = ui:GetChild("IconNumberTxt")
  uis.BuyOverImage = ui:GetChild("BuyOverImage")
  uis.CostFreeImage = ui:GetChild("CostFreeImage")
  uis.c2Ctr = ui:GetController("c2")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


