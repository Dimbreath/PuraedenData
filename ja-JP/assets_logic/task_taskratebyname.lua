-- params : ...
-- function num : 0 , upvalues : _ENV
require("Task_TaskLineByName")
require("Task_TaskRewardByName")
GetTask_TaskRateUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.Line_01 = GetTask_TaskLineUis(ui:GetChild("Line_01"))
  uis.Line_02 = GetTask_TaskLineUis(ui:GetChild("Line_02"))
  uis.Line_03 = GetTask_TaskLineUis(ui:GetChild("Line_03"))
  uis.Line_04 = GetTask_TaskLineUis(ui:GetChild("Line_04"))
  uis.Line_05 = GetTask_TaskLineUis(ui:GetChild("Line_05"))
  uis.Line_06 = GetTask_TaskLineUis(ui:GetChild("Line_06"))
  uis.Reward_01 = GetTask_TaskRewardUis(ui:GetChild("Reward_01"))
  uis.Reward_02 = GetTask_TaskRewardUis(ui:GetChild("Reward_02"))
  uis.Reward_03 = GetTask_TaskRewardUis(ui:GetChild("Reward_03"))
  uis.Reward_04 = GetTask_TaskRewardUis(ui:GetChild("Reward_04"))
  uis.Reward_05 = GetTask_TaskRewardUis(ui:GetChild("Reward_05"))
  uis.Reward_06 = GetTask_TaskRewardUis(ui:GetChild("Reward_06"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


