-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Arena_ChallengeListGrpByName")
require("Arena_CardTipsLeftGrpByName")
require("Arena_CardTipsRightGrpByName")
GetArena_ArenaUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateGrp = ui:GetChild("DecorateGrp")
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.MySelfLoader = ui:GetChild("MySelfLoader")
  uis.EnemyLoader = ui:GetChild("EnemyLoader")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.ChallengeListGrp = GetArena_ChallengeListGrpUis(ui:GetChild("ChallengeListGrp"))
  uis.MySelfGrp = GetArena_CardTipsLeftGrpUis(ui:GetChild("MySelfGrp"))
  uis.EnemyGrp = GetArena_CardTipsRightGrpUis(ui:GetChild("EnemyGrp"))
  uis.MidInformationGrp = ui:GetChild("MidInformationGrp")
  uis.BattleBtn = ui:GetChild("BattleBtn")
  uis.BuyBtn = ui:GetChild("BuyBtn")
  uis.RecordBtn = ui:GetChild("RecordBtn")
  uis.DefenseFormationBtn = ui:GetChild("DefenseFormationBtn")
  uis.RewardBtn = ui:GetChild("RewardBtn")
  uis.ShopBtn = ui:GetChild("ShopBtn")
  uis.SkipBtn = ui:GetChild("SkipBtn")
  uis.SkipTxt = ui:GetChild("SkipTxt")
  uis.BottomInformationGrp = ui:GetChild("BottomInformationGrp")
  uis.VSImage = ui:GetChild("VSImage")
  uis.TimeImage = ui:GetChild("TimeImage")
  uis.TimeImage = ui:GetChild("TimeImage")
  uis.TimeImage = ui:GetChild("TimeImage")
  uis.TimeWordTxt = ui:GetChild("TimeWordTxt")
  uis.TimeEndTxt = ui:GetChild("TimeEndTxt")
  uis.root = ui
  return uis
end


