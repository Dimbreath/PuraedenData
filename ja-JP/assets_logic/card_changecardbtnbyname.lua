-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_ChangeCardBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.QBanLoader = ui:GetChild("QBanLoader")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


