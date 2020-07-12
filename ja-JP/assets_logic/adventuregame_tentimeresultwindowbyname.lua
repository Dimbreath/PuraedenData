-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CommonResource_Popup_BByName")
require("AdventureGame_TenTimeResultByName")
GetAdventureGame_TenTimeResultWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_B = GetCommonResource_Popup_BUis(ui:GetChild("Popup_B"))
  uis.TenTimeResultGrp = GetAdventureGame_TenTimeResultUis(ui:GetChild("TenTimeResultGrp"))
  uis.root = ui
  return uis
end


