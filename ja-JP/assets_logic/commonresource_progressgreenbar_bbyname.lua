-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_ProgressGreenFill_BByName")
GetCommonResource_ProgressGreenBar_BUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetCommonResource_ProgressGreenFill_BUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


