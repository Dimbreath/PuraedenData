-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_DefenseFillByName")
GetBattle_DefenseBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_DefenseFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


