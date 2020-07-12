-- params : ...
-- function num : 0 , upvalues : _ENV
GetShop_SaleTipCompUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.SaleTxt = ui:GetChild("SaleTxt")
  uis.root = ui
  return uis
end


