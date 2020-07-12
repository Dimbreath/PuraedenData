-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_BattleUpUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.EggLoader = ui:GetChild("EggLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.root = ui
  return uis
end


