-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_IntimacyPanelFillByName")
GetHandBook_IntimacyPanelBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetHandBook_IntimacyPanelFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


