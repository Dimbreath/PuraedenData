-- params : ...
-- function num : 0 , upvalues : _ENV
GetArena_RewardFraction_01_GrpUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Fraction_01_Txt = ui:GetChild("Fraction_01_Txt")
  uis.Fraction_02_Txt = ui:GetChild("Fraction_02_Txt")
  uis.FractionRewardList = ui:GetChild("FractionRewardList")
  uis.GetBtn = ui:GetChild("GetBtn")
  uis.RewardFraction_01_Grp = ui:GetChild("RewardFraction_01_Grp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


