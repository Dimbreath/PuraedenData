-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_02ByName")
require("Expedition_ExpeditionShopTipsByName")
GetExpedition_ExpeditionShopUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.Line = GetCommonResource_Line_02Uis(ui:GetChild("Line"))
  uis.Tips_01 = GetExpedition_ExpeditionShopTipsUis(ui:GetChild("Tips_01"))
  uis.Tips_02 = GetExpedition_ExpeditionShopTipsUis(ui:GetChild("Tips_02"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


