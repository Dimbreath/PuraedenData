-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
require("Card_StarUpEffectByName")
GetCard_StarGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.DecorateGrp = ui:GetChild("DecorateGrp")
  uis.CardPicesLoader = ui:GetChild("CardPicesLoader")
  uis.ButtonOneBtn = ui:GetChild("ButtonOneBtn")
  uis.ButtonTwoBtn = ui:GetChild("ButtonTwoBtn")
  uis.GoldBackImage = ui:GetChild("GoldBackImage")
  uis.GoldImage = ui:GetChild("GoldImage")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.StarNumberTxt = ui:GetChild("StarNumberTxt")
  uis.TipsBtn = ui:GetChild("TipsBtn")
  uis.HeadFrameGrp = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrameGrp"))
  uis.StarList = ui:GetChild("StarList")
  uis.UpGrp = GetCard_StarUpEffectUis(ui:GetChild("UpGrp"))
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.StarDebrisChangeBtn = ui:GetChild("StarDebrisChangeBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


