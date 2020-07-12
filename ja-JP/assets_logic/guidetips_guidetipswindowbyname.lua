-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuideTips_GuideTipsWindowUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TipsList = ui:GetChild("TipsList")
  uis.root = ui
  return uis
end


