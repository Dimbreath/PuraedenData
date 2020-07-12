-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_StageStateUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.StageNumberTxt = ui:GetChild("StageNumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


