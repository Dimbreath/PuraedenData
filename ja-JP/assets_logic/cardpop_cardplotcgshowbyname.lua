-- params : ...
-- function num : 0 , upvalues : _ENV
require("Share_InformationByName")
GetCardPop_CardPlotCGShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.PictureLoader = ui:GetChild("PictureLoader")
  uis.Lock_02_Image = ui:GetChild("Lock_02_Image")
  uis.Lock_03_Image = ui:GetChild("Lock_03_Image")
  uis.LockGrp = ui:GetChild("LockGrp")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NameGrp = ui:GetChild("NameGrp")
  uis.TimeImage = ui:GetChild("TimeImage")
  uis.TimeImage = ui:GetChild("TimeImage")
  uis.TimeImage = ui:GetChild("TimeImage")
  uis.CGWordTxt = ui:GetChild("CGWordTxt")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.Information = GetShare_InformationUis(ui:GetChild("Information"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


