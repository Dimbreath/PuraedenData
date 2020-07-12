-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_LevelFillByName")
GetCard_LevelBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetCard_LevelFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


