-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_ExchangeFillByName")
GetCard_ExchangeBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetCard_ExchangeFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


