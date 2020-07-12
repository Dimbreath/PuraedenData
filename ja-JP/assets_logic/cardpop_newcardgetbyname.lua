-- params : ...
-- function num : 0 , upvalues : _ENV
require("CardPop_CardGetEffectByName")
require("Share_InformationByName")
GetCardPop_NewCardGetUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlueImage = ui:GetChild("BlueImage")
  uis.PurpleImage = ui:GetChild("PurpleImage")
  uis.OrangeImage = ui:GetChild("OrangeImage")
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.CardGetEffect = GetCardPop_CardGetEffectUis(ui:GetChild("CardGetEffect"))
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.Information = GetShare_InformationUis(ui:GetChild("Information"))
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


