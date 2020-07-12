-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_TenTimeUIUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.titlenameTxt = ui:GetChild("titlenameTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.EventList = ui:GetChild("EventList")
  uis.GoldBackImage = ui:GetChild("GoldBackImage")
  uis.SpendLoader = ui:GetChild("SpendLoader")
  uis.SpendTxt = ui:GetChild("SpendTxt")
  uis.root = ui
  return uis
end


