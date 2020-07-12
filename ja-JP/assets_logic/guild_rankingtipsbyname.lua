-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_PlayerHeadByName")
GetGuild_RankingTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlayerHeadGrp = GetGuild_PlayerHeadUis(ui:GetChild("PlayerHeadGrp"))
  uis.CardNameTxt = ui:GetChild("CardNameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.ItemList = ui:GetChild("ItemList")
  uis.Ranking_01_Image = ui:GetChild("Ranking_01_Image")
  uis.FirstGrp = ui:GetChild("FirstGrp")
  uis.Ranking_02_Image = ui:GetChild("Ranking_02_Image")
  uis.SecondGrp = ui:GetChild("SecondGrp")
  uis.Ranking_03_Image = ui:GetChild("Ranking_03_Image")
  uis.ThirdGrp = ui:GetChild("ThirdGrp")
  uis.Ranking_04_Image = ui:GetChild("Ranking_04_Image")
  uis.Ranking_04_Txt = ui:GetChild("Ranking_04_Txt")
  uis.FouthGrp = ui:GetChild("FouthGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


