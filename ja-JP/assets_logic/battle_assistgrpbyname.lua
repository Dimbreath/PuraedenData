-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_AssistGrpUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.AssitHeadLoader = ui:GetChild("AssitHeadLoader")
  uis.SkllLeftImage = ui:GetChild("SkllLeftImage")
  uis.SkllRightImage = ui:GetChild("SkllRightImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


