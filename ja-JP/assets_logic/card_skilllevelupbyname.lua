-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_SkillLevelUpUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Name_01_Txt = ui:GetChild("Name_01_Txt")
  uis.Number_01_Txt = ui:GetChild("Number_01_Txt")
  uis.OneGrp = ui:GetChild("OneGrp")
  uis.Name_02_Txt = ui:GetChild("Name_02_Txt")
  uis.Number_02_Txt = ui:GetChild("Number_02_Txt")
  uis.TwoGrp = ui:GetChild("TwoGrp")
  uis.Name_03_Txt = ui:GetChild("Name_03_Txt")
  uis.Number_03_Txt = ui:GetChild("Number_03_Txt")
  uis.ThreeGrp = ui:GetChild("ThreeGrp")
  uis.Name_04_Txt = ui:GetChild("Name_04_Txt")
  uis.Number_04_Txt = ui:GetChild("Number_04_Txt")
  uis.FourGrp = ui:GetChild("FourGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


