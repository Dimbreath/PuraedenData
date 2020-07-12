-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_RedDollUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.RedImage = ui:GetChild("RedImage")
  uis.root = ui
  return uis
end


