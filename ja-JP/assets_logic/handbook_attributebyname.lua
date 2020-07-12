-- params : ...
-- function num : 0 , upvalues : _ENV
GetHandBook_AttributeUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


