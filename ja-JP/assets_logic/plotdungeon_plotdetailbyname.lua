-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("CommonResource_Line_03ByName")
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
GetPlotDungeon_PlotDetailUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n94 = GetCommonResource_Line_04Uis(ui:GetChild("n94"))
  uis.PlotImageLoader = ui:GetChild("PlotImageLoader")
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.ChallengeBtn = ui:GetChild("ChallengeBtn")
  uis.sweepaway10Btn = ui:GetChild("sweepaway10Btn")
  uis.sweepawayBtn = ui:GetChild("sweepawayBtn")
  uis.n100 = GetCommonResource_Line_03Uis(ui:GetChild("n100"))
  uis.Prop1List = ui:GetChild("Prop1List")
  uis.DropDisplayTxt = ui:GetChild("DropDisplayTxt")
  uis.Drop1ListGrp = ui:GetChild("Drop1ListGrp")
  uis.DecorateImage = GetCommonResource_Base_01Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Base_02Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Base_01Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Base_02Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Base_01Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Base_02Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.mycombatTxt = ui:GetChild("mycombatTxt")
  uis.mycombatnumberTxt = ui:GetChild("mycombatnumberTxt")
  uis.recommendedcombatTxt = ui:GetChild("recommendedcombatTxt")
  uis.recommendedcombatmumberTxt = ui:GetChild("recommendedcombatmumberTxt")
  uis.vitalityTxt = ui:GetChild("vitalityTxt")
  uis.vitalitynumberTxt = ui:GetChild("vitalitynumberTxt")
  uis.vitalitynumber_01_Txt = ui:GetChild("vitalitynumber_01_Txt")
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.challengenumberTxt = ui:GetChild("challengenumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


