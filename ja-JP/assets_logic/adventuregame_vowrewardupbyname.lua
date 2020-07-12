-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_VowProcess_02ByName")
require("AdventureGame_VowProcess_01ByName")
GetAdventureGame_VowRewardUpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.TipsList = ui:GetChild("TipsList")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.RewardUpTxt = ui:GetChild("RewardUpTxt")
  uis.VP_01 = GetAdventureGame_VowProcess_02Uis(ui:GetChild("VP_01"))
  uis.VP_02 = GetAdventureGame_VowProcess_02Uis(ui:GetChild("VP_02"))
  uis.VP_03 = GetAdventureGame_VowProcess_01Uis(ui:GetChild("VP_03"))
  uis.VP_04 = GetAdventureGame_VowProcess_02Uis(ui:GetChild("VP_04"))
  uis.VP_05 = GetAdventureGame_VowProcess_02Uis(ui:GetChild("VP_05"))
  uis.VP_06 = GetAdventureGame_VowProcess_02Uis(ui:GetChild("VP_06"))
  uis.VP_07 = GetAdventureGame_VowProcess_01Uis(ui:GetChild("VP_07"))
  uis.root = ui
  return uis
end


