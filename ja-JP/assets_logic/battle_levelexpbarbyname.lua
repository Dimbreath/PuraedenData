-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_LevelExpFillByName")
GetBattle_LevelExpBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_LevelExpFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


