-- params : ...
-- function num : 0 , upvalues : _ENV
GetPlotDungeon_Animation_LockUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Lock_01_Image = ui:GetChild("Lock_01_Image")
  uis.Lock_02_Image = ui:GetChild("Lock_02_Image")
  uis.Lock_03_Image = ui:GetChild("Lock_03_Image")
  uis.root = ui
  return uis
end


