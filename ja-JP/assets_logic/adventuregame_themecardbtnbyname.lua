-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_RedDollByName")
GetAdventureGame_ThemeCardBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardNameLoader = ui:GetChild("CardNameLoader")
  uis.CardHeadLoader = ui:GetChild("CardHeadLoader")
  uis.PointOneTxt = ui:GetChild("PointOneTxt")
  uis.OneGrp = ui:GetChild("OneGrp")
  uis.PointTwoTxt = ui:GetChild("PointTwoTxt")
  uis.TwoGrp = ui:GetChild("TwoGrp")
  uis.PointThreeTxt = ui:GetChild("PointThreeTxt")
  uis.ThreeGrp = ui:GetChild("ThreeGrp")
  uis.WordImage = ui:GetChild("WordImage")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


