-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetMessage_GetNumberUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.GetNumberImage = ui:GetChild("GetNumberImage")
  uis.GetNumberImage = GetCommonResource_Line_03Uis(ui:GetChild("GetNumberImage"))
  uis.GetNumberImage = GetCommonResource_Line_03Uis(ui:GetChild("GetNumberImage"))
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.GetNumberTxt = ui:GetChild("GetNumberTxt")
  uis.root = ui
  return uis
end


