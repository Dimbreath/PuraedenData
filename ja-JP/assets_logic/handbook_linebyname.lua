-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_Line_AByName")
require("HandBook_Line_BByName")
GetHandBook_LineUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Line_01 = GetHandBook_Line_AUis(ui:GetChild("Line_01"))
  uis.Line_02 = GetHandBook_Line_BUis(ui:GetChild("Line_02"))
  uis.root = ui
  return uis
end


