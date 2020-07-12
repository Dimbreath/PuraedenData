-- params : ...
-- function num : 0 , upvalues : _ENV
GetTower_CardPositionUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Own_01_Image = ui:GetChild("Own_01_Image")
  uis.Enemy_02_Image = ui:GetChild("Enemy_02_Image")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


