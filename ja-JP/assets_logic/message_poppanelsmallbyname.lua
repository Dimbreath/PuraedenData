-- params : ...
-- function num : 0 , upvalues : _ENV
GetMessage_popPanelsmallUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.ChallengeBtn = ui:GetChild("ChallengeBtn")
  uis.CancleBtn = ui:GetChild("CancleBtn")
  uis.SpendImage = ui:GetChild("SpendImage")
  uis.BindingDiamondLoader = ui:GetChild("BindingDiamondLoader")
  uis.BindingDiamondTxt = ui:GetChild("BindingDiamondTxt")
  uis.BindingDiamondGrp = ui:GetChild("BindingDiamondGrp")
  uis.DiamondLoader = ui:GetChild("DiamondLoader")
  uis.DiamondTxt = ui:GetChild("DiamondTxt")
  uis.DiamondGrp = ui:GetChild("DiamondGrp")
  uis.SpendTipsBtn = ui:GetChild("SpendTipsBtn")
  uis.SpendTipsTxt = ui:GetChild("SpendTipsTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


