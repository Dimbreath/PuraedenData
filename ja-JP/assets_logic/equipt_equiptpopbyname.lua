-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_EquiptIconByName")
GetEquipt_EquiptPopUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.EquiptIcon = GetCommonResource_EquiptIconUis(ui:GetChild("EquiptIcon"))
  uis.CarryImage = ui:GetChild("CarryImage")
  uis.ExclusiveTxt = ui:GetChild("ExclusiveTxt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.LockBtn = ui:GetChild("LockBtn")
  uis.ReplaceBtn = ui:GetChild("ReplaceBtn")
  uis.PopList = ui:GetChild("PopList")
  uis.root = ui
  return uis
end


