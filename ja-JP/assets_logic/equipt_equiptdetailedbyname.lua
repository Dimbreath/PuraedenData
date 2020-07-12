-- params : ...
-- function num : 0 , upvalues : _ENV
GetEquipt_EquiptDetailedUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.DetailedList = ui:GetChild("DetailedList")
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.NothingTxt = ui:GetChild("NothingTxt")
  uis.CardQLoader = ui:GetChild("CardQLoader")
  uis.NothingGrp = ui:GetChild("NothingGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


