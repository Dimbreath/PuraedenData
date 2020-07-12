-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BottomHpFillByName")
GetBattle_BottomHpBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_BottomHpFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


