-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CGcollection_CGShowByName")
GetCGcollection_CGUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NameGrp = ui:GetChild("NameGrp")
  uis.CGShow = GetCGcollection_CGShowUis(ui:GetChild("CGShow"))
  uis.TouchScreenTxt = ui:GetChild("TouchScreenTxt")
  uis.root = ui
  return uis
end


