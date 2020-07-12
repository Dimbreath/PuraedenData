-- params : ...
-- function num : 0 , upvalues : _ENV
require("BattleDataCount_RecordBattleDataCardFillByName")
GetBattleDataCount_RecordBattleDataCardBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattleDataCount_RecordBattleDataCardFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


