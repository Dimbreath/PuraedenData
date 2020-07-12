-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_GuessItem_07Uis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ItemLoader = ui:GetChild("ItemLoader")
  uis.RewardLoader = ui:GetChild("RewardLoader")
  uis.TouchBtn = ui:GetChild("TouchBtn")
  uis.root = ui
  return uis
end


