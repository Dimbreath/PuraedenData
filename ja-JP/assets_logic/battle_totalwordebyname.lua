-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_TotalWordEUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CritArtTxt = ui:GetChild("CritArtTxt")
  uis.NormalArtTxt = ui:GetChild("NormalArtTxt")
  uis.TotalDamageEGrp = ui:GetChild("TotalDamageEGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


