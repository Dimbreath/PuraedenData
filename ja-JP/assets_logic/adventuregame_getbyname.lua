-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_GetUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.root = ui
  return uis
end


