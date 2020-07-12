-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetPlotDungeon_PropClenNormalListUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n21 = GetCommonResource_Line_03Uis(ui:GetChild("n21"))
  uis.expiconImage = ui:GetChild("expiconImage")
  uis.goldiconImage = ui:GetChild("goldiconImage")
  uis.ItemList = ui:GetChild("ItemList")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.expnumberTxt = ui:GetChild("expnumberTxt")
  uis.goldnumberTxt = ui:GetChild("goldnumberTxt")
  uis.root = ui
  return uis
end


