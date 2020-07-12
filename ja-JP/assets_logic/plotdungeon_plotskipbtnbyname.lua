-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotDungeon_Animation_ClearByName")
require("PlotDungeon_Animation_LockByName")
require("PlotDungeon_Animation_NowByName")
require("PlotDungeon_Message_AByName")
GetPlotDungeon_PlotSkipBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_00_Image = ui:GetChild("Decorate_00_Image")
  uis.CardQLoader = ui:GetChild("CardQLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.ClearGrp = GetPlotDungeon_Animation_ClearUis(ui:GetChild("ClearGrp"))
  uis.LockGrp = GetPlotDungeon_Animation_LockUis(ui:GetChild("LockGrp"))
  uis.NowGrp = GetPlotDungeon_Animation_NowUis(ui:GetChild("NowGrp"))
  uis.Message_A = GetPlotDungeon_Message_AUis(ui:GetChild("Message_A"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


