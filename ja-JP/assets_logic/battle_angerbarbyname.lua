-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_AngerFillByName")
GetBattle_AngerBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_AngerFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


