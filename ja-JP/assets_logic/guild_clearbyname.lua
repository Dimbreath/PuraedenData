-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_ClearUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TouchBtn = ui:GetChild("TouchBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


