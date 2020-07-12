-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityDungeon_RewardShowUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.EndTimeTxt = ui:GetChild("EndTimeTxt")
  uis.RewardList = ui:GetChild("RewardList")
  uis.LabelList = ui:GetChild("LabelList")
  uis.root = ui
  return uis
end


