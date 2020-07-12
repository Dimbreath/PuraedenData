-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_AnswerBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.UnSelectedImage = ui:GetChild("UnSelectedImage")
  uis.SelectedImage = ui:GetChild("SelectedImage")
  uis.OrderTxt = ui:GetChild("OrderTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


