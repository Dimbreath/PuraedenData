-- params : ...
-- function num : 0 , upvalues : _ENV
GetTask_TaskRewardUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Effect_02_Image = ui:GetChild("Effect_02_Image")
  uis.Effect_01_Image = ui:GetChild("Effect_01_Image")
  uis.ChoiceImage = ui:GetChild("ChoiceImage")
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.Number_01_Txt = ui:GetChild("Number_01_Txt")
  uis.Number_02_Txt = ui:GetChild("Number_02_Txt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


