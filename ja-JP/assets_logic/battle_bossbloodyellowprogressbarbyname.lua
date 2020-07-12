-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BossBloodYellowProgressFillByName")
GetBattle_BossBloodYellowProgressBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_BossBloodYellowProgressFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


