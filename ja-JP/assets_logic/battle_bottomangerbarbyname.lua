-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BottomAngerFillByName")
GetBattle_BottomAngerBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_BottomAngerFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


