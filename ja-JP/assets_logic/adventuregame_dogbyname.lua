-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_DogUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.DogLoader = ui:GetChild("DogLoader")
  uis.root = ui
  return uis
end


