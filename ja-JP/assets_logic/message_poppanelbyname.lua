-- params : ...
-- function num : 0 , upvalues : _ENV
GetMessage_popPanelUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.ItemList = ui:GetChild("ItemList")
  uis.ChallengeBtn = ui:GetChild("ChallengeBtn")
  uis.LockTxt = ui:GetChild("LockTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


