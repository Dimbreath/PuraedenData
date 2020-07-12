-- params : ...
-- function num : 0 , upvalues : _ENV
GetHandBook_IntimacyCardInfo_BUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.ShuXingNameTxt = ui:GetChild("ShuXingNameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


