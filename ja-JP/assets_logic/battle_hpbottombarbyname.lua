-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_HpBottomFillByName")
GetBattle_HpBottomBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_HpBottomFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


