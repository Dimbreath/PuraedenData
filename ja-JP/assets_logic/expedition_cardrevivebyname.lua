-- params : ...
-- function num : 0 , upvalues : _ENV
GetExpedition_CardReviveUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CardList = ui:GetChild("CardList")
  uis.root = ui
  return uis
end


