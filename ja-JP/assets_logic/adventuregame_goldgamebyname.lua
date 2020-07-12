-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_RefreshByName")
require("AdventureGame_DogByName")
require("AdventureGame_GetByName")
require("AdventureGame_GoldGameRewardByName")
require("AdventureGame_Animation_StartByName")
require("AdventureGame_Animation_OverByName")
require("AdventureGame_BrickTalkByName")
GetAdventureGame_GoldGameUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.RefreshGrp = GetAdventureGame_RefreshUis(ui:GetChild("RefreshGrp"))
  uis.ClockImage = ui:GetChild("ClockImage")
  uis.DogGrp = GetAdventureGame_DogUis(ui:GetChild("DogGrp"))
  uis.GetGrp = GetAdventureGame_GetUis(ui:GetChild("GetGrp"))
  uis.RewardGrp = GetAdventureGame_GoldGameRewardUis(ui:GetChild("RewardGrp"))
  uis.Animation_StartGrp = GetAdventureGame_Animation_StartUis(ui:GetChild("Animation_StartGrp"))
  uis.Animation_OverGrp = GetAdventureGame_Animation_OverUis(ui:GetChild("Animation_OverGrp"))
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.ReduceTimeTxt = ui:GetChild("ReduceTimeTxt")
  uis.BrickTalkGrp = GetAdventureGame_BrickTalkUis(ui:GetChild("BrickTalkGrp"))
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


