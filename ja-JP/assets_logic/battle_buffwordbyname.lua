-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_BuffWordUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BattleWordLoader = ui:GetChild("BattleWordLoader")
  uis.root = ui
  return uis
end


