-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_AttributeByName")
GetHandBook_AttributeTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Attribute_01_Grp = GetHandBook_AttributeUis(ui:GetChild("Attribute_01_Grp"))
  uis.Attribute_02_Grp = GetHandBook_AttributeUis(ui:GetChild("Attribute_02_Grp"))
  uis.Attribute_03_Grp = GetHandBook_AttributeUis(ui:GetChild("Attribute_03_Grp"))
  uis.Attribute_04_Grp = GetHandBook_AttributeUis(ui:GetChild("Attribute_04_Grp"))
  uis.Attribute_05_Grp = GetHandBook_AttributeUis(ui:GetChild("Attribute_05_Grp"))
  uis.Attribute_06_Grp = GetHandBook_AttributeUis(ui:GetChild("Attribute_06_Grp"))
  uis.Attribute_07_Grp = GetHandBook_AttributeUis(ui:GetChild("Attribute_07_Grp"))
  uis.Attribute_08_Grp = GetHandBook_AttributeUis(ui:GetChild("Attribute_08_Grp"))
  uis.Attribute_09_Grp = GetHandBook_AttributeUis(ui:GetChild("Attribute_09_Grp"))
  uis.Word_00_Txt = ui:GetChild("Word_00_Txt")
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.Word_02_Txt = ui:GetChild("Word_02_Txt")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


