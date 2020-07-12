-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_AttributeUpByName")
GetCard_StarSingleAttributeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n5 = GetCard_AttributeUpUis(ui:GetChild("n5"))
  uis.ATK_02_Image = ui:GetChild("ATK_02_Image")
  uis.root = ui
  return uis
end


