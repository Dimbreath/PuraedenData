-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("Expedition_BuffIconByName")
GetExpedition_BuffTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TipsImage = ui:GetChild("TipsImage")
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.BuffIconGrp = GetExpedition_BuffIconUis(ui:GetChild("BuffIconGrp"))
  uis.BuffNameTxt = ui:GetChild("BuffNameTxt")
  uis.BuffWord_01_Txt = ui:GetChild("BuffWord_01_Txt")
  uis.BuffWord_02_Txt = ui:GetChild("BuffWord_02_Txt")
  uis.root = ui
  return uis
end


