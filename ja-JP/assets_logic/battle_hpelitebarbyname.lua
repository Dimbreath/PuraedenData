-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_HpEliteFillByName")
GetBattle_HpEliteBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_HpEliteFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


