-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AllItemIconByName")
GetActivityDungeon_RewardUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AllItemIcon = GetCommonResource_AllItemIconUis(ui:GetChild("AllItemIcon"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.ItemNumberTxt = ui:GetChild("ItemNumberTxt")
  uis.root = ui
  return uis
end


