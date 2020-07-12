-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CommonResource_Popup_SByName")
require("Message_popPanelsmallByName")
GetMessage_popPanelsmallWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_S = GetCommonResource_Popup_SUis(ui:GetChild("Popup_S"))
  uis.popPanelsmall = GetMessage_popPanelsmallUis(ui:GetChild("popPanelsmall"))
  uis.root = ui
  return uis
end


