-- params : ...
-- function num : 0 , upvalues : _ENV
require("CardPop_RepeatByName")
GetCardPop_RepeatTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Repeat = GetCardPop_RepeatUis(ui:GetChild("Repeat"))
  uis.root = ui
  return uis
end


