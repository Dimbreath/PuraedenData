-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("Guild_BuyNumberByName")
GetGuild_BuyNumberWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.BuyNumberGrp = GetGuild_BuyNumberUis(ui:GetChild("BuyNumberGrp"))
  uis.root = ui
  return uis
end


