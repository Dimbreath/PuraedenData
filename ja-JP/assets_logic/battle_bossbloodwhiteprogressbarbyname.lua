-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BossBloodWhiteProgressFillByName")
GetBattle_BossBloodWhiteProgressBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_BossBloodWhiteProgressFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


