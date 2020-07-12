-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetTower_RewardTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n1 = GetCommonResource_Line_03Uis(ui:GetChild("n1"))
  uis.RewardList = ui:GetChild("RewardList")
  uis.ShowTxt = ui:GetChild("ShowTxt")
  uis.LuckTxt = ui:GetChild("LuckTxt")
  uis.LuckNumberTxt = ui:GetChild("LuckNumberTxt")
  uis.TipsBtn = ui:GetChild("TipsBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


