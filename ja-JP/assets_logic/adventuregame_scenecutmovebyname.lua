-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_SceneCutByName")
GetAdventureGame_SceneCutMoveUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.SceneCut = GetAdventureGame_SceneCutUis(ui:GetChild("SceneCut"))
  uis.root = ui
  return uis
end


