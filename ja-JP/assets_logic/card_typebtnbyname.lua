-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_TypeBtnBgByName")
GetCard_TypeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TypeBtnBg = GetCard_TypeBtnBgUis(ui:GetChild("TypeBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


