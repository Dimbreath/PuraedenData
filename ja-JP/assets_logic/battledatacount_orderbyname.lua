-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattleDataCount_OrderUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.OrderImage = ui:GetChild("OrderImage")
  uis.OrderMyTxt = ui:GetChild("OrderMyTxt")
  uis.root = ui
  return uis
end


