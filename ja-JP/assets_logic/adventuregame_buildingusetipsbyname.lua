-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_BuildingUseTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.SeatTxt = ui:GetChild("SeatTxt")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.Lock_01_Image = ui:GetChild("Lock_01_Image")
  uis.Lock_02_Image = ui:GetChild("Lock_02_Image")
  uis.LockTxt = ui:GetChild("LockTxt")
  uis.Add_01_Image = ui:GetChild("Add_01_Image")
  uis.Add_02_Image = ui:GetChild("Add_02_Image")
  uis.AddTxt = ui:GetChild("AddTxt")
  uis.BattleWordTxt = ui:GetChild("BattleWordTxt")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


