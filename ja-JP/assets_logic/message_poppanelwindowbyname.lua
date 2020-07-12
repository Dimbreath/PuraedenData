-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
require("Message_popPanelByName")
GetMessage_popPanelWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.popPanel = GetMessage_popPanelUis(ui:GetChild("popPanel"))
  uis.root = ui
  return uis
end


