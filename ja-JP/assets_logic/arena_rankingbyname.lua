-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_RankCardLoaderPicByName")
require("Title_TitlePicByName")
GetArena_RankingUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.RankingTxt = ui:GetChild("RankingTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.ButtonBtn = ui:GetChild("ButtonBtn")
  uis.BattleInformationList = ui:GetChild("BattleInformationList")
  uis.RankCardLoaderPic = GetArena_RankCardLoaderPicUis(ui:GetChild("RankCardLoaderPic"))
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.MaxImage = ui:GetChild("MaxImage")
  uis.MaxImage = ui:GetChild("MaxImage")
  uis.MaxImage = ui:GetChild("MaxImage")
  uis.MaxRankingTxt = ui:GetChild("MaxRankingTxt")
  uis.MaxGrp = ui:GetChild("MaxGrp")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NameImage = ui:GetChild("NameImage")
  uis.NowRankingTxt = ui:GetChild("NowRankingTxt")
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.CardShowGrp = ui:GetChild("CardShowGrp")
  uis.root = ui
  return uis
end


