-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_CritWordNumberCompByName")
GetBattle_CritWordNumberUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CritWordNumberComp = GetBattle_CritWordNumberCompUis(ui:GetChild("CritWordNumberComp"))
  uis.root = ui
  return uis
end


