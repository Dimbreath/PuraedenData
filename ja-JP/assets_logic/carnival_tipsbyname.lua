-- params : ...
-- function num : 0 , upvalues : _ENV
GetCarnival_TipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.GetNumberTxt = ui:GetChild("GetNumberTxt")
  uis.TaskNumberTxt = ui:GetChild("TaskNumberTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.HeadLoader = ui:GetChild("HeadLoader")
  uis.GetBtn = ui:GetChild("GetBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


