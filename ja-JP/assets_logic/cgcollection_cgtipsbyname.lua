-- params : ...
-- function num : 0 , upvalues : _ENV
GetCGcollection_CGTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.Lock_01_Image = ui:GetChild("Lock_01_Image")
  uis.Lock_02_Image = ui:GetChild("Lock_02_Image")
  uis.Lock_03_Image = ui:GetChild("Lock_03_Image")
  uis.Lock_04_Image = ui:GetChild("Lock_04_Image")
  uis.Lock_05_Image = ui:GetChild("Lock_05_Image")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.LockTxt = ui:GetChild("LockTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


