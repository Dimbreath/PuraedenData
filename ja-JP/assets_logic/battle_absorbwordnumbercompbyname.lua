-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_AbsorbWordNumberCompUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.StateLoader = ui:GetChild("StateLoader")
  uis.root = ui
  return uis
end


