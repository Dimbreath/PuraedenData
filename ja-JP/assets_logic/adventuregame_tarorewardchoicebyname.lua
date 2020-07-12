-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
GetAdventureGame_TaroRewardChoiceUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.RewardList = ui:GetChild("RewardList")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.CloseTxt = ui:GetChild("CloseTxt")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.SubtitleImage = ui:GetChild("SubtitleImage")
  uis.SubtitleImage = ui:GetChild("SubtitleImage")
  uis.SubtitleBtn = ui:GetChild("SubtitleBtn")
  uis.SubtitleTxt = ui:GetChild("SubtitleTxt")
  uis.SubtitleWordTxt = ui:GetChild("SubtitleWordTxt")
  uis.ShootBtn = ui:GetChild("ShootBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


