-- params : ...
-- function num : 0 , upvalues : _ENV
require("Land_BlackBgAniByName")
require("CommonResource_Popup_SByName")
require("Land_CurrencyByName")
GetLand_CurrencyWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetLand_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_S = GetCommonResource_Popup_SUis(ui:GetChild("Popup_S"))
  uis.Currency = GetLand_CurrencyUis(ui:GetChild("Currency"))
  uis.root = ui
  return uis
end


