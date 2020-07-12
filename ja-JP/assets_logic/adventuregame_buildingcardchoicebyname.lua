-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_BuildingCardChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CardInfoList = ui:GetChild("CardInfoList")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


