-- params : ...
-- function num : 0 , upvalues : _ENV
GetHome_AppointmentBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.AppointmentImage = ui:GetChild("AppointmentImage")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


