-- params : ...
-- function num : 0 , upvalues : _ENV
GetMessage_BuyTipsMessageUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.Word_02_Txt = ui:GetChild("Word_02_Txt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.SpendImage = ui:GetChild("SpendImage")
  uis.BindingDiamondLoader = ui:GetChild("BindingDiamondLoader")
  uis.BindingDiamondTxt = ui:GetChild("BindingDiamondTxt")
  uis.BindingDiamondGrp = ui:GetChild("BindingDiamondGrp")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.ChangeNumberTxt = ui:GetChild("ChangeNumberTxt")
  uis.ReduceBtn = ui:GetChild("ReduceBtn")
  uis.AddBtn = ui:GetChild("AddBtn")
  uis.MaxBtn = ui:GetChild("MaxBtn")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.BuyBtn = ui:GetChild("BuyBtn")
  uis.MinBtn = ui:GetChild("MinBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


