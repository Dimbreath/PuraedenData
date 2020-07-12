-- params : ...
-- function num : 0 , upvalues : _ENV
GetArena_RewardRankingGrpUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.RankingList = ui:GetChild("RankingList")
  uis.Ranking_01_Txt = ui:GetChild("Ranking_01_Txt")
  uis.Ranking_02_Txt = ui:GetChild("Ranking_02_Txt")
  uis.MySelfRankingList = ui:GetChild("MySelfRankingList")
  uis.MySelfGrp = ui:GetChild("MySelfGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


