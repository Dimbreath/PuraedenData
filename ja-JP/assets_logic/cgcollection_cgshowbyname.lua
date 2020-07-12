-- params : ...
-- function num : 0 , upvalues : _ENV
require("CGcollection_CGImageByName")
GetCGcollection_CGShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CGImage = GetCGcollection_CGImageUis(ui:GetChild("CGImage"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


