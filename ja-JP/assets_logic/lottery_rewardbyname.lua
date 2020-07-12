-- params : ...
-- function num : 0 , upvalues : _ENV
require("Lottery_EffectByName")
require("Lottery_CardByName")
require("Lottery_ItemByName")
GetLottery_RewardUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Effect = GetLottery_EffectUis(ui:GetChild("Effect"))
  uis.Card = GetLottery_CardUis(ui:GetChild("Card"))
  uis.Item = GetLottery_ItemUis(ui:GetChild("Item"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


