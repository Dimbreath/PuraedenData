-- params : ...
-- function num : 0 , upvalues : _ENV
GetArena_SumTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.FractionRewardList = ui:GetChild("FractionRewardList")
  uis.root = ui
  return uis
end


