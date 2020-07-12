-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_AttributeUpByName")
GetCard_StarDebrisChangeAttributeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AttributeUp = GetCard_AttributeUpUis(ui:GetChild("AttributeUp"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NowNumberTxt = ui:GetChild("NowNumberTxt")
  uis.AfterNumberTxt = ui:GetChild("AfterNumberTxt")
  uis.root = ui
  return uis
end


