-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_CardChoicePicShowUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PictureLoader = ui:GetChild("PictureLoader")
  uis.root = ui
  return uis
end


