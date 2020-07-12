-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_CardChoicePicUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CardShowLoader = ui:GetChild("CardShowLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


