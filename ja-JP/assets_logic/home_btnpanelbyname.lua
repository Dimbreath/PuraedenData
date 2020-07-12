-- params : ...
-- function num : 0 , upvalues : _ENV
GetHome_BtnPanelUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BackGroundBtn = ui:GetChild("BackGroundBtn")
  uis.HideBtn = ui:GetChild("HideBtn")
  uis.root = ui
  return uis
end


