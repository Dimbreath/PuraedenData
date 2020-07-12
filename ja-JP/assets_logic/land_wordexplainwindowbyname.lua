-- params : ...
-- function num : 0 , upvalues : _ENV
require("Land_BlackBgAniByName")
require("CommonResource_Popup_BByName")
require("Land_WordExplainByName")
GetLand_WordExplainWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetLand_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_B = GetCommonResource_Popup_BUis(ui:GetChild("Popup_B"))
  uis.WordExplain = GetLand_WordExplainUis(ui:GetChild("WordExplain"))
  uis.root = ui
  return uis
end


