-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("Guild_BuyResultByName")
GetGuild_BuyResultWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.BuyResultGrp = GetGuild_BuyResultUis(ui:GetChild("BuyResultGrp"))
  uis.root = ui
  return uis
end


