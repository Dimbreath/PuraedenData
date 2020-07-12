-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_AbsorbWordNumberCompByName")
GetBattle_AbsorbWordNumberUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AbsorbWordNumberComp = GetBattle_AbsorbWordNumberCompUis(ui:GetChild("AbsorbWordNumberComp"))
  uis.root = ui
  return uis
end


