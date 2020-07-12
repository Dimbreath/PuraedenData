-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_UnMakeEventUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.titlenameTxt = ui:GetChild("titlenameTxt")
  uis.EventList = ui:GetChild("EventList")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


