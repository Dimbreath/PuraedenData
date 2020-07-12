-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetActivity_SignUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.Decorate_06_Image = ui:GetChild("Decorate_06_Image")
  uis.Decorate_07_Image = ui:GetChild("Decorate_07_Image")
  uis.Decorate_08_Image = ui:GetChild("Decorate_08_Image")
  uis.Decorate_09_Image = ui:GetChild("Decorate_09_Image")
  uis.Decorate_10_Image = ui:GetChild("Decorate_10_Image")
  uis.Decorate_11_Image = ui:GetChild("Decorate_11_Image")
  uis.Decorate_12_Image = GetCommonResource_Line_03Uis(ui:GetChild("Decorate_12_Image"))
  uis.ItemList = ui:GetChild("ItemList")
  uis.TotalItemList = ui:GetChild("TotalItemList")
  uis.TotalNumberTxt = ui:GetChild("TotalNumberTxt")
  uis.TotalGetBtn = ui:GetChild("TotalGetBtn")
  uis.TotalDayTxt = ui:GetChild("TotalDayTxt")
  uis.root = ui
  return uis
end


