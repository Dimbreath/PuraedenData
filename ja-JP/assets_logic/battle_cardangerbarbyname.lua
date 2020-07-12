-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_CardAngerFillByName")
GetBattle_CardAngerBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_CardAngerFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


