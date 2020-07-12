-- params : ...
-- function num : 0 , upvalues : _ENV
GetHandBook_PageUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


