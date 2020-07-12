-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuide_HandUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.HandLoader = ui:GetChild("HandLoader")
  uis.root = ui
  return uis
end


