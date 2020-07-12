-- params : ...
-- function num : 0 , upvalues : _ENV
require("BattleDataCount_DefFillByName")
GetBattleDataCount_DefBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattleDataCount_DefFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


