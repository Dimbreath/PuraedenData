-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_PositionByName")
GetAdventureGame_Bridge_AUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Position = GetAdventureGame_PositionUis(ui:GetChild("Position"))
  uis.root = ui
  return uis
end


