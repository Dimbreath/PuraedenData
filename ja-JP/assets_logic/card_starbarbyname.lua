-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_StarFillByName")
GetCard_StarBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetCard_StarFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


