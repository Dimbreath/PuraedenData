-- params : ...
-- function num : 0 , upvalues : _ENV
GetDailyDungeon_ChoiceCardUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.GoldImage = ui:GetChild("GoldImage")
  uis.ExpImage = ui:GetChild("ExpImage")
  uis.EquipImage = ui:GetChild("EquipImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


