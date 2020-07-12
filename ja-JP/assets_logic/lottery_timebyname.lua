-- params : ...
-- function num : 0 , upvalues : _ENV
GetLottery_TimeUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.StartTxt = ui:GetChild("StartTxt")
  uis.EndTxt = ui:GetChild("EndTxt")
  uis.root = ui
  return uis
end


