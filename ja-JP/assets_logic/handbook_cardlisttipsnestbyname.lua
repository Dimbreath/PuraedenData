-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_CardListTipsByName")
GetHandBook_CardListTipsNestUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardListTips = GetHandBook_CardListTipsUis(ui:GetChild("CardListTips"))
  uis.root = ui
  return uis
end


