-- params : ...
-- function num : 0 , upvalues : _ENV
GetGift_GiftChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.ItemList = ui:GetChild("ItemList")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


