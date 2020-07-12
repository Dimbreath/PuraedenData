-- params : ...
-- function num : 0 , upvalues : _ENV
GetExpedition_ChoiceDifficultyUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.IntoBtn = ui:GetChild("IntoBtn")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


