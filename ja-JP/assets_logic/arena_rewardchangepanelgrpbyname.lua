-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_RewardFractionGrpByName")
require("Arena_RewardCareerGrpByName")
require("Arena_RewardRankingGrpByName")
GetArena_RewardChangePanelGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.FractionBtn = ui:GetChild("FractionBtn")
  uis.CareerBtn = ui:GetChild("CareerBtn")
  uis.RankingBtn = ui:GetChild("RankingBtn")
  uis.RewardFractionGrp = GetArena_RewardFractionGrpUis(ui:GetChild("RewardFractionGrp"))
  uis.RewardCareerGrp = GetArena_RewardCareerGrpUis(ui:GetChild("RewardCareerGrp"))
  uis.RewardRankingGrp = GetArena_RewardRankingGrpUis(ui:GetChild("RewardRankingGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


