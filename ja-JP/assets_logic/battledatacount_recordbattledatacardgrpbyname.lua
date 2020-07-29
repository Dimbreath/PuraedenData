-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
require("BattleDataCount_OrderByName")
GetBattleDataCount_RecordBattleDataCardGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.HeadFrameGrp = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrameGrp"))
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.BattleSettleProgressBar = ui:GetChild("BattleSettleProgressBar")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.DefTxt = ui:GetChild("DefTxt")
  uis.Order = GetBattleDataCount_OrderUis(ui:GetChild("Order"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


