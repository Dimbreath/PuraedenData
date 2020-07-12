-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_StarAttributeTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.Attribute_01_List = ui:GetChild("Attribute_01_List")
  uis.Word_02_Txt = ui:GetChild("Word_02_Txt")
  uis.Attribute_02_List = ui:GetChild("Attribute_02_List")
  uis.root = ui
  return uis
end


