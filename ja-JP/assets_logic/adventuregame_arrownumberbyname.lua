-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_ArrowNumberUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


