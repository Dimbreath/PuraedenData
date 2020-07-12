-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
GetGetWay_GetWayUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_01_Image = GetCommonResource_Line_04Uis(ui:GetChild("Decorate_01_Image"))
  uis.ItemLoader = ui:GetChild("ItemLoader")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.GetWayList = ui:GetChild("GetWayList")
  uis.GetWayTxt = ui:GetChild("GetWayTxt")
  uis.Close_01_Btn = ui:GetChild("Close_01_Btn")
  uis.Button_01_Btn = ui:GetChild("Button_01_Btn")
  uis.ExchangeBtn = ui:GetChild("ExchangeBtn")
  uis.GetWayGrp = ui:GetChild("GetWayGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


