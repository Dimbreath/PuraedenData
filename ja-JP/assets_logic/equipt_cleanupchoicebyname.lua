-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
GetEquipt_CleanUpChoiceUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.CleanUpList = ui:GetChild("CleanUpList")
  uis.ResetBtn = ui:GetChild("ResetBtn")
  uis.SortBtn = ui:GetChild("SortBtn")
  uis.CleanUpGrp = ui:GetChild("CleanUpGrp")
  uis.root = ui
  return uis
end


