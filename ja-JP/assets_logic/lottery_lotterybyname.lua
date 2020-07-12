-- params : ...
-- function num : 0 , upvalues : _ENV
require("Lottery_LotteryPanelByName")
require("CommonResource_AssetStripByName")
require("Lottery_StartWordByName")
require("Lottery_GechaCardEffectGrpByName")
GetLottery_LotteryUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.LotteryPanelGrp = GetLottery_LotteryPanelUis(ui:GetChild("LotteryPanelGrp"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.UselessTxt = ui:GetChild("UselessTxt")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.VideoLoader = ui:GetChild("VideoLoader")
  uis.StartWord = GetLottery_StartWordUis(ui:GetChild("StartWord"))
  uis.GechaCardEffectGrp = GetLottery_GechaCardEffectGrpUis(ui:GetChild("GechaCardEffectGrp"))
  uis.root = ui
  return uis
end


