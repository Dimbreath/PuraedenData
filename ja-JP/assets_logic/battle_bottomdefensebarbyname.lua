-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BottomDefenseFillByName")
GetBattle_BottomDefenseBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_BottomDefenseFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


