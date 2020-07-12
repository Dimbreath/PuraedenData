-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BossBloodBlueProgressFillByName")
GetBattle_BossBloodBlueProgressBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_BossBloodBlueProgressFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


