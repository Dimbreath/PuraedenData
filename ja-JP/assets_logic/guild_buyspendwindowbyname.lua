-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("Guild_BuySpendByName")
GetGuild_BuySpendWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.BuySpendGrp = GetGuild_BuySpendUis(ui:GetChild("BuySpendGrp"))
  uis.root = ui
  return uis
end


