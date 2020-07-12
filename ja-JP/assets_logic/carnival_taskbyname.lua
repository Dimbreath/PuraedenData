-- params : ...
-- function num : 0 , upvalues : _ENV
GetCarnival_TaskUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ChoiceList = ui:GetChild("ChoiceList")
  uis.TimeNumberTxt = ui:GetChild("TimeNumberTxt")
  uis.TaskList = ui:GetChild("TaskList")
  uis.root = ui
  return uis
end


