-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetFormation_LineUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.LineImage = GetCommonResource_Line_03Uis(ui:GetChild("LineImage"))
  uis.root = ui
  return uis
end


