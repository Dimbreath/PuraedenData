-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_AssetsButtonUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.AssetsSmallIconLoader = ui:GetChild("AssetsSmallIconLoader")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


