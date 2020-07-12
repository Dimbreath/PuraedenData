-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_CirclePropFrameUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.GreenImage = ui:GetChild("GreenImage")
  uis.BlueImage = ui:GetChild("BlueImage")
  uis.PurpleImage = ui:GetChild("PurpleImage")
  uis.YellowImage = ui:GetChild("YellowImage")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.PlusImage = ui:GetChild("PlusImage")
  uis.StageTxt = ui:GetChild("StageTxt")
  uis.PlusImage = ui:GetChild("PlusImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


