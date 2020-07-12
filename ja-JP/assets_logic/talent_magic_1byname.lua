-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_TriangleByName")
GetTalent_Magic_1Uis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Triangle = GetTalent_TriangleUis(ui:GetChild("Triangle"))
  uis.Magic_1_Btn = ui:GetChild("Magic_1_Btn")
  uis.Magic_2_Btn = ui:GetChild("Magic_2_Btn")
  uis.Magic_3_Btn = ui:GetChild("Magic_3_Btn")
  uis.Magic_4_Btn = ui:GetChild("Magic_4_Btn")
  uis.Magic_5_Btn = ui:GetChild("Magic_5_Btn")
  uis.Magic_6_Btn = ui:GetChild("Magic_6_Btn")
  uis.root = ui
  return uis
end


