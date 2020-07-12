-- params : ...
-- function num : 0 , upvalues : _ENV
GetShop_RefreshBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.RefreshItemLoader = ui:GetChild("RefreshItemLoader")
  uis.RefreshNumberTxt = ui:GetChild("RefreshNumberTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


