-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BossBloodOrangeProgressFillByName")
GetBattle_BossBloodOrangeProgressBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_BossBloodOrangeProgressFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


