-- params : ...
-- function num : 0 , upvalues : _ENV
require("Lottery_EffectByName")
require("Lottery_GetCha_NewCardUpGrpByName")
require("Lottery_GetCha_CardGrpByName")
require("Lottery_GetCha_CouponGrpByName")
require("Lottery_GetCha_NewCardGrpByName")
require("Lottery_Sure_CardGrpByName")
require("Lottery_TimeByName")
GetLottery_LotteryPanelUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.EffectGrp = GetLottery_EffectUis(ui:GetChild("EffectGrp"))
  uis.GetCha_NewCardUpGrp = GetLottery_GetCha_NewCardUpGrpUis(ui:GetChild("GetCha_NewCardUpGrp"))
  uis.GetCha_CardGrp = GetLottery_GetCha_CardGrpUis(ui:GetChild("GetCha_CardGrp"))
  uis.GetCha_CouponGrp = GetLottery_GetCha_CouponGrpUis(ui:GetChild("GetCha_CouponGrp"))
  uis.GetCha_NewCardGrp = GetLottery_GetCha_NewCardGrpUis(ui:GetChild("GetCha_NewCardGrp"))
  uis.Sure_CardGrp = GetLottery_Sure_CardGrpUis(ui:GetChild("Sure_CardGrp"))
  uis.ButtonList = ui:GetChild("ButtonList")
  uis.Time = GetLottery_TimeUis(ui:GetChild("Time"))
  uis.ProbabilityBtn = ui:GetChild("ProbabilityBtn")
  uis.BgImage = ui:GetChild("BgImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


