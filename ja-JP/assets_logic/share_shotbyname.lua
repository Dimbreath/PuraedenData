-- params : ...
-- function num : 0 , upvalues : _ENV
GetShare_ShotUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ShotLoader = ui:GetChild("ShotLoader")
  uis.root = ui
  return uis
end


