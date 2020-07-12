-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CommonResource_Popup_BByName")
require("Expedition_ExpeditionShopByName")
GetExpedition_ExpeditionShopWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_B = GetCommonResource_Popup_BUis(ui:GetChild("Popup_B"))
  uis.ExpeditionShop = GetExpedition_ExpeditionShopUis(ui:GetChild("ExpeditionShop"))
  uis.root = ui
  return uis
end


