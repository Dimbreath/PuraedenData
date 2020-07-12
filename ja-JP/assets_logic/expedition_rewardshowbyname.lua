-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("CommonResource_Line_03ByName")
GetExpedition_RewardShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n104 = GetCommonResource_Line_04Uis(ui:GetChild("n104"))
  uis.PlotImageLoader = ui:GetChild("PlotImageLoader")
  uis.n108 = GetCommonResource_Line_03Uis(ui:GetChild("n108"))
  uis.Prop1List = ui:GetChild("Prop1List")
  uis.DropDisplayTxt = ui:GetChild("DropDisplayTxt")
  uis.Drop1ListGrp = ui:GetChild("Drop1ListGrp")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.IntoBtn = ui:GetChild("IntoBtn")
  uis.TitileNameTxt = ui:GetChild("TitileNameTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.Buff_01_Txt = ui:GetChild("Buff_01_Txt")
  uis.Buff_02_Txt = ui:GetChild("Buff_02_Txt")
  uis.Buff_01_Grp = ui:GetChild("Buff_01_Grp")
  uis.Buff_03_Txt = ui:GetChild("Buff_03_Txt")
  uis.Buff_04_Txt = ui:GetChild("Buff_04_Txt")
  uis.Buff_02_Grp = ui:GetChild("Buff_02_Grp")
  uis.BuffGrp = ui:GetChild("BuffGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


