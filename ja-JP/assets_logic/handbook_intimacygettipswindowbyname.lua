-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_IntimacyGetTipsByName")
GetHandBook_IntimacyGetTipsWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.IntimacyGetTips = GetHandBook_IntimacyGetTipsUis(ui:GetChild("IntimacyGetTips"))
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


