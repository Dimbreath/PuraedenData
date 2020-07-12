-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_ProgressYellowFill_AByName")
GetCommonResource_ProgressYellowBar_AUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetCommonResource_ProgressYellowFill_AUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


