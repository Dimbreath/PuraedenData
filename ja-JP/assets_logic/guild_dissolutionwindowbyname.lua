-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CommonResource_Popup_SByName")
require("Guild_DissolutionTipsByName")
GetGuild_DissolutionWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_S = GetCommonResource_Popup_SUis(ui:GetChild("Popup_S"))
  uis.DissolutionTipsGrp = GetGuild_DissolutionTipsUis(ui:GetChild("DissolutionTipsGrp"))
  uis.root = ui
  return uis
end


