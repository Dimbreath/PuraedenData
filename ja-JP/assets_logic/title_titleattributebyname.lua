-- params : ...
-- function num : 0 , upvalues : _ENV
GetTitle_TitleAttributeUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.AttributeNameTxt = ui:GetChild("AttributeNameTxt")
  uis.AttributeNumberTxt = ui:GetChild("AttributeNumberTxt")
  uis.root = ui
  return uis
end


