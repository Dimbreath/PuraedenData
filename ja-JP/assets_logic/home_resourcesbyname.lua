-- params : ...
-- function num : 0 , upvalues : _ENV
GetHome_ResourcesUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.IconTxt = ui:GetChild("IconTxt")
  uis.root = ui
  return uis
end


