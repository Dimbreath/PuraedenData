-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_LoveBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Love_03_Image = ui:GetChild("Love_03_Image")
  uis.Love_02_Image = ui:GetChild("Love_02_Image")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


