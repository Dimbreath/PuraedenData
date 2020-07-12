-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
GetTower_NumberUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n27 = GetCommonResource_Base_01Uis(ui:GetChild("n27"))
  uis.n28 = GetCommonResource_Base_02Uis(ui:GetChild("n28"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.root = ui
  return uis
end


