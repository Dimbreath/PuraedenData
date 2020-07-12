-- params : ...
-- function num : 0 , upvalues : _ENV
GetGift_StageChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.CardList = ui:GetChild("CardList")
  uis.StageItemList = ui:GetChild("StageItemList")
  uis.ResetBtn = ui:GetChild("ResetBtn")
  uis.GiftNumberImage = ui:GetChild("GiftNumberImage")
  uis.GiftNumberTxt = ui:GetChild("GiftNumberTxt")
  uis.root = ui
  return uis
end


