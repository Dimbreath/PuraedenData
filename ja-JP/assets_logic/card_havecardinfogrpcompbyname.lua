-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_StageCardinfoByName")
require("CommonResource_RedDollByName")
GetCard_HaveCardinfoGrpCompUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HeadLoader = ui:GetChild("HeadLoader")
  uis.CardDebrisProgressBar = ui:GetChild("CardDebrisProgressBar")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.Star_01_Image = ui:GetChild("Star_01_Image")
  uis.Star_02_Image = ui:GetChild("Star_02_Image")
  uis.Star_03_Image = ui:GetChild("Star_03_Image")
  uis.Star_04_Image = ui:GetChild("Star_04_Image")
  uis.Star_05_Image = ui:GetChild("Star_05_Image")
  uis.Star_06_Image = ui:GetChild("Star_06_Image")
  uis.Star_07_Image = ui:GetChild("Star_07_Image")
  uis.FragmentNumberTxt = ui:GetChild("FragmentNumberTxt")
  uis.StageCardinfo = GetCard_StageCardinfoUis(ui:GetChild("StageCardinfo"))
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


