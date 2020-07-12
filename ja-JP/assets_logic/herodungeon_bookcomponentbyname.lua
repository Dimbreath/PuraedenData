-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_RedDollByName")
GetHeroDungeon_BookComponentUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.ProgressionTxt = ui:GetChild("ProgressionTxt")
  uis.ClearTxt = ui:GetChild("ClearTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


