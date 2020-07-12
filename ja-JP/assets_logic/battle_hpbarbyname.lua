-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_HpFillByName")
GetBattle_HpBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_HpFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


