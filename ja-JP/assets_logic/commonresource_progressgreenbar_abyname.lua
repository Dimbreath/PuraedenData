-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_ProgressGreenFill_AByName")
GetCommonResource_ProgressGreenBar_AUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetCommonResource_ProgressGreenFill_AUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


