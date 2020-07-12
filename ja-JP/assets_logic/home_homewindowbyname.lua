-- params : ...
-- function num : 0 , upvalues : _ENV
require("Home_HomeCtrlByName")
GetHome_HomeWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundLoader = ui:GetChild("BackgroundLoader")
  uis.ShowLoader = ui:GetChild("ShowLoader")
  uis.HomeCtrl = GetHome_HomeCtrlUis(ui:GetChild("HomeCtrl"))
  uis.root = ui
  return uis
end


