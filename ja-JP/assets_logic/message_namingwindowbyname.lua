-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("Message_NamingByName")
GetMessage_NamingWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.NamingGrp = GetMessage_NamingUis(ui:GetChild("NamingGrp"))
  uis.root = ui
  return uis
end


