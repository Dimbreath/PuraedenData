-- params : ...
-- function num : 0 , upvalues : _ENV
GetTalent_AttributeUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ArrowImage = ui:GetChild("ArrowImage")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NowTxt = ui:GetChild("NowTxt")
  uis.AfterTxt = ui:GetChild("AfterTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


