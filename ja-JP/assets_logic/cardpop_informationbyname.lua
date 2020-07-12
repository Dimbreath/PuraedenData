-- params : ...
-- function num : 0 , upvalues : _ENV
require("CardPop_CardLabelByName")
GetCardPop_InformationUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.StarList = ui:GetChild("StarList")
  uis.JueseNameLoader = ui:GetChild("JueseNameLoader")
  uis.AptitudeIcon_UR_Image = ui:GetChild("AptitudeIcon_UR_Image")
  uis.AptitudeIcon_SSR_Image = ui:GetChild("AptitudeIcon_SSR_Image")
  uis.AptitudeIcon_SR_Image = ui:GetChild("AptitudeIcon_SR_Image")
  uis.AptitudeIcon_R_Image = ui:GetChild("AptitudeIcon_R_Image")
  uis.CVImage = ui:GetChild("CVImage")
  uis.CVNameLoader = ui:GetChild("CVNameLoader")
  uis.Three = GetCardPop_CardLabelUis(ui:GetChild("Three"))
  uis.Two = GetCardPop_CardLabelUis(ui:GetChild("Two"))
  uis.One = GetCardPop_CardLabelUis(ui:GetChild("One"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


