-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_CardLabelUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.LabelTxt = ui:GetChild("LabelTxt")
  uis.root = ui
  return uis
end


