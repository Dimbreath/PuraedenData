-- params : ...
-- function num : 0 , upvalues : _ENV
GetTask_TaskPanelUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.DayBtn = ui:GetChild("DayBtn")
  uis.WeekBtn = ui:GetChild("WeekBtn")
  uis.AlwaysBtn = ui:GetChild("AlwaysBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


