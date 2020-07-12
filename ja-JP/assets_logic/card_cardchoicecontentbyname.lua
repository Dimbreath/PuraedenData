-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_CardChoiceCompByName")
GetCard_CardChoiceContentUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardChoiceComp = GetCard_CardChoiceCompUis(ui:GetChild("CardChoiceComp"))
  uis.root = ui
  return uis
end


