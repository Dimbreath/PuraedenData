-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_CardHeadListCmpUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.root = ui
  return uis
end


