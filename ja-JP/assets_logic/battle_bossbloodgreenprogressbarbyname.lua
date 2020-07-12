-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BossBloodGreenProgressFillByName")
GetBattle_BossBloodGreenProgressBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_BossBloodGreenProgressFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


