-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("CommonResource_Line_03ByName")
GetTitle_Title_CUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Line_04Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Line_03Uis(ui:GetChild("DecorateImage"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.TitleList = ui:GetChild("TitleList")
  uis.UseBtn = ui:GetChild("UseBtn")
  uis.root = ui
  return uis
end


