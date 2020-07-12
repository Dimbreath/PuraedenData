-- params : ...
-- function num : 0 , upvalues : _ENV
GetBag_EquiptInfoUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.InfoList = ui:GetChild("InfoList")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


