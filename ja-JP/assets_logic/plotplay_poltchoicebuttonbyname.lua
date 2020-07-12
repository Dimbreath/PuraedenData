-- params : ...
-- function num : 0 , upvalues : _ENV
GetPlotPlay_PoltChoiceButtonUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ChoiceTxt = ui:GetChild("ChoiceTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


