-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_BuffIconUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BuffIconLoader = ui:GetChild("BuffIconLoader")
  uis.LoaderTxt = ui:GetChild("LoaderTxt")
  uis.root = ui
  return uis
end


