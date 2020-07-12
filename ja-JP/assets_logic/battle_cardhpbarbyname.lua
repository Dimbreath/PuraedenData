-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_CardHpFillByName")
GetBattle_CardHpBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_CardHpFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


