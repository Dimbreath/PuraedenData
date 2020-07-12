-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_TalkByName")
GetGuild_BuyResultUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.RewardTxt = ui:GetChild("RewardTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.BuyResultList = ui:GetChild("BuyResultList")
  uis.GetWordTxt = ui:GetChild("GetWordTxt")
  uis.DebrisLoader = ui:GetChild("DebrisLoader")
  uis.DebrisNumberTxt = ui:GetChild("DebrisNumberTxt")
  uis.AnimationLoader = ui:GetChild("AnimationLoader")
  uis.TalkGrp = GetGuild_TalkUis(ui:GetChild("TalkGrp"))
  uis.BuyResultGrp = ui:GetChild("BuyResultGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


