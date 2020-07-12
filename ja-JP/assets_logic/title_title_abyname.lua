-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
GetTitle_Title_AUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Line_04Uis(ui:GetChild("DecorateImage"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.TitleList = ui:GetChild("TitleList")
  uis.root = ui
  return uis
end


