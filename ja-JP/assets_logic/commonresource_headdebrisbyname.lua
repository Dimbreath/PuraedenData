-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_PeacecompByName")
GetCommonResource_HeadDebrisUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PeacecompGrp = GetCommonResource_PeacecompUis(ui:GetChild("PeacecompGrp"))
  uis.QualityOrangeImage = ui:GetChild("QualityOrangeImage")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.FirstPassImage = ui:GetChild("FirstPassImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


