-- params : ...
-- function num : 0 , upvalues : _ENV
GetHome_PictureUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PictureLoader = ui:GetChild("PictureLoader")
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.Word_02_Txt = ui:GetChild("Word_02_Txt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


