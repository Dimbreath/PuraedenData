-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BossBloodRedProgressFillByName")
GetBattle_BossBloodRedProgressBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_BossBloodRedProgressFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


