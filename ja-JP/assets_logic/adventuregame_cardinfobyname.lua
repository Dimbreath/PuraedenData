-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
require("AdventureGame_ArrowNumberByName")
GetAdventureGame_CardInfoUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardNameTxt = ui:GetChild("CardNameTxt")
  uis.HeadFrameGrp = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrameGrp"))
  uis.BattleWordTxt = ui:GetChild("BattleWordTxt")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.RateWordTxt = ui:GetChild("RateWordTxt")
  uis.RateNumberTxt = ui:GetChild("RateNumberTxt")
  uis.ChoiceBtn = ui:GetChild("ChoiceBtn")
  uis.CancelBtn = ui:GetChild("CancelBtn")
  uis.ArrowNumberGrp = GetAdventureGame_ArrowNumberUis(ui:GetChild("ArrowNumberGrp"))
  uis.UesingTxt = ui:GetChild("UesingTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


