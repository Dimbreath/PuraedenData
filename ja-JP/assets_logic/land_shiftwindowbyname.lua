-- params : ...
-- function num : 0 , upvalues : _ENV
require("Land_BlackBgAniByName")
require("CommonResource_Popup_SByName")
require("Land_ShiftByName")
GetLand_ShiftWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetLand_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_S = GetCommonResource_Popup_SUis(ui:GetChild("Popup_S"))
  uis.Shift = GetLand_ShiftUis(ui:GetChild("Shift"))
  uis.root = ui
  return uis
end


