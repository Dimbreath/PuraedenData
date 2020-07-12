-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_TenTimeUITipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.SpendLoader = ui:GetChild("SpendLoader")
  uis.SpendNumberTxt = ui:GetChild("SpendNumberTxt")
  uis.ChoiceBtn = ui:GetChild("ChoiceBtn")
  uis.SpendGrp = ui:GetChild("SpendGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


