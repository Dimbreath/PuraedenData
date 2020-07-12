-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_ProgressYellowFill_BByName")
GetCommonResource_ProgressYellowBar_BUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetCommonResource_ProgressYellowFill_BUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


