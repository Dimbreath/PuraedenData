-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_SkillAllUpUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.AllUpBtn = ui:GetChild("AllUpBtn")
  uis.SpendBackImage = ui:GetChild("SpendBackImage")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.SpendLoader = ui:GetChild("SpendLoader")
  uis.SpendTxt = ui:GetChild("SpendTxt")
  uis.SpendGrp = ui:GetChild("SpendGrp")
  uis.root = ui
  return uis
end


