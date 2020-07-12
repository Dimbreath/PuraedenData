-- params : ...
-- function num : 0 , upvalues : _ENV
GetPlotPlay_CutUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.PictureLoader = ui:GetChild("PictureLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


