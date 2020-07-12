-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BossHpProgressFillByName")
GetBattle_BossHpProgressBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_BossHpProgressFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


