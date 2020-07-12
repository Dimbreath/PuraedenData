-- params : ...
-- function num : 0 , upvalues : _ENV
GetPlotPlay_MenuPopOutWindowUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BacklookTxt = ui:GetChild("BacklookTxt")
  uis.HideTxt = ui:GetChild("HideTxt")
  uis.AutoTxt = ui:GetChild("AutoTxt")
  uis.BackLookBtn = ui:GetChild("BackLookBtn")
  uis.HideBtn = ui:GetChild("HideBtn")
  uis.AutoBtn = ui:GetChild("AutoBtn")
  uis.root = ui
  return uis
end


