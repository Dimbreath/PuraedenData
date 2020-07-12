-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_StarAttributeTipsByName")
GetCard_StarAttributeTipsWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.StarAttributeTipsGrp = GetCard_StarAttributeTipsUis(ui:GetChild("StarAttributeTipsGrp"))
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


