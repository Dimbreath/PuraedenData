-- params : ...
-- function num : 0 , upvalues : _ENV
require("Land_BlackBgAniByName")
require("CommonResource_Popup_BByName")
require("Land_PactByName")
GetLand_PactWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetLand_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_B = GetCommonResource_Popup_BUis(ui:GetChild("Popup_B"))
  uis.Pact = GetLand_PactUis(ui:GetChild("Pact"))
  uis.root = ui
  return uis
end


