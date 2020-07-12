-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_DebrisNumberFillByName")
GetCard_DebrisNumberBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetCard_DebrisNumberFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


