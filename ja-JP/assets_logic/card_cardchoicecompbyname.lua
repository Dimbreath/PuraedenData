-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_CardChoicePicByName")
require("Card_StageStateByName")
require("Card_CardChoiceEffectByName")
GetCard_CardChoiceCompUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardChoicePic = GetCard_CardChoicePicUis(ui:GetChild("CardChoicePic"))
  uis.StageState = GetCard_StageStateUis(ui:GetChild("StageState"))
  uis.StageTxtImage = ui:GetChild("StageTxtImage")
  uis.StageTxt = ui:GetChild("StageTxt")
  uis.CardChoiceEffect = GetCard_CardChoiceEffectUis(ui:GetChild("CardChoiceEffect"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


