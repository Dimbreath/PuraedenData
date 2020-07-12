-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
GetEquipt_EquiptScreenUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.ScreenList = ui:GetChild("ScreenList")
  uis.root = ui
  return uis
end


