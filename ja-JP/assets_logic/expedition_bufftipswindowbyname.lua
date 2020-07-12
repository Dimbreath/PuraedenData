-- params : ...
-- function num : 0 , upvalues : _ENV
require("Expedition_BuffTipsByName")
GetExpedition_BuffTipsWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BuffTipsGrp = GetExpedition_BuffTipsUis(ui:GetChild("BuffTipsGrp"))
  uis.root = ui
  return uis
end


