-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_HurtProgressFillByName")
GetBattle_HurtProgressBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_HurtProgressFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end

