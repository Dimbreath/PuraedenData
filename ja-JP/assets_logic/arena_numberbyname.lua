-- params : ...
-- function num : 0 , upvalues : _ENV
GetArena_NumberUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.root = ui
  return uis
end


