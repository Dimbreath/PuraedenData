-- params : ...
-- function num : 0 , upvalues : _ENV
GetMail_WordUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ContentTxt = ui:GetChild("ContentTxt")
  uis.Icon_01_Image = ui:GetChild("Icon_01_Image")
  uis.root = ui
  return uis
end


