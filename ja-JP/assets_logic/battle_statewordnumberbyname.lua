-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_StateWordNumberCompByName")
GetBattle_StateWordNumberUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.StateWordNumberComp = GetBattle_StateWordNumberCompUis(ui:GetChild("StateWordNumberComp"))
  uis.root = ui
  return uis
end


