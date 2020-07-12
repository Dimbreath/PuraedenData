-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CommonResource_Popup_BByName")
require("Card_StarDebrisChangeGrpByName")
GetCard_StarDebrisChangeGrpWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_B = GetCommonResource_Popup_BUis(ui:GetChild("Popup_B"))
  uis.StarDebrisChangeGrp = GetCard_StarDebrisChangeGrpUis(ui:GetChild("StarDebrisChangeGrp"))
  uis.root = ui
  return uis
end


