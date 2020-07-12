-- params : ...
-- function num : 0 , upvalues : _ENV
GetHandBook_CardPictureLoaderPicUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CardPictureLoader = ui:GetChild("CardPictureLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


