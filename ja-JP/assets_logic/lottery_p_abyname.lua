-- params : ...
-- function num : 0 , upvalues : _ENV
GetLottery_P_AUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.ProbabilityTxt = ui:GetChild("ProbabilityTxt")
  uis.CardList = ui:GetChild("CardList")
  uis.root = ui
  return uis
end


