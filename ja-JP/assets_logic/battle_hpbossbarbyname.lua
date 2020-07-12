-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_HpBossFillByName")
GetBattle_HpBossBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_HpBossFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


