-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_LineByName")
require("HandBook_CardPlotBattleTips_BByName")
require("HandBook_CardPlotBattleTips_AByName")
GetHandBook_Map_001Uis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.LineGrp = GetHandBook_LineUis(ui:GetChild("LineGrp"))
  uis.Tips_01_Grp = GetHandBook_CardPlotBattleTips_BUis(ui:GetChild("Tips_01_Grp"))
  uis.Tips_02_Grp = GetHandBook_CardPlotBattleTips_AUis(ui:GetChild("Tips_02_Grp"))
  uis.Tips_03_Grp = GetHandBook_CardPlotBattleTips_BUis(ui:GetChild("Tips_03_Grp"))
  uis.Tips_04_Grp = GetHandBook_CardPlotBattleTips_BUis(ui:GetChild("Tips_04_Grp"))
  uis.Tips_05_Grp = GetHandBook_CardPlotBattleTips_AUis(ui:GetChild("Tips_05_Grp"))
  uis.Tips_06_Grp = GetHandBook_CardPlotBattleTips_BUis(ui:GetChild("Tips_06_Grp"))
  uis.Tips_07_Grp = GetHandBook_CardPlotBattleTips_BUis(ui:GetChild("Tips_07_Grp"))
  uis.Tips_08_Grp = GetHandBook_CardPlotBattleTips_AUis(ui:GetChild("Tips_08_Grp"))
  uis.Tips_09_Grp = GetHandBook_CardPlotBattleTips_BUis(ui:GetChild("Tips_09_Grp"))
  uis.Tips_10_Grp = GetHandBook_CardPlotBattleTips_BUis(ui:GetChild("Tips_10_Grp"))
  uis.root = ui
  return uis
end


