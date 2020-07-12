-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CommonResource_Popup_SByName")
require("AdventureGame_BuildingSureByName")
GetAdventureGame_BuildingSureWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_S = GetCommonResource_Popup_SUis(ui:GetChild("Popup_S"))
  uis.BuildingSureGrp = GetAdventureGame_BuildingSureUis(ui:GetChild("BuildingSureGrp"))
  uis.root = ui
  return uis
end


