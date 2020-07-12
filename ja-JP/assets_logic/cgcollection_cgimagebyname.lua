-- params : ...
-- function num : 0 , upvalues : _ENV
GetCGcollection_CGImageUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CGLoader = ui:GetChild("CGLoader")
  uis.root = ui
  return uis
end


