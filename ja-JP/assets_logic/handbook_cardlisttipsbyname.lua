-- params : ...
-- function num : 0 , upvalues : _ENV
GetHandBook_CardListTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.Number_1_Txt = ui:GetChild("Number_1_Txt")
  uis.CardList = ui:GetChild("CardList")
  uis.GoBtn = ui:GetChild("GoBtn")
  uis.LookBtn = ui:GetChild("LookBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


