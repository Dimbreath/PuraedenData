-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_QualityGrpCompUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


