-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_DoubleRewardUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.root = ui
  return uis
end


