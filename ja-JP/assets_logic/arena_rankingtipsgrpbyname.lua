-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
require("Title_TitlePicByName")
GetArena_RankingTipsGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.GuildImage = GetCommonResource_Base_01Uis(ui:GetChild("GuildImage"))
  uis.GuildImage = GetCommonResource_Base_02Uis(ui:GetChild("GuildImage"))
  uis.BattleTxt = ui:GetChild("BattleTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.HeadImage = ui:GetChild("HeadImage")
  uis.HeadLoader = ui:GetChild("HeadLoader")
  uis.HeadGrp = ui:GetChild("HeadGrp")
  uis.LvNumTxt = ui:GetChild("LvNumTxt")
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.Ranking_01_Image = ui:GetChild("Ranking_01_Image")
  uis.FirstGrp = ui:GetChild("FirstGrp")
  uis.Ranking_02_Image = ui:GetChild("Ranking_02_Image")
  uis.SecondGrp = ui:GetChild("SecondGrp")
  uis.Ranking_03_Image = ui:GetChild("Ranking_03_Image")
  uis.ThirdGrp = ui:GetChild("ThirdGrp")
  uis.Ranking_04_Image = ui:GetChild("Ranking_04_Image")
  uis.Ranking_04_Txt = ui:GetChild("Ranking_04_Txt")
  uis.FouthGrp = ui:GetChild("FouthGrp")
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


