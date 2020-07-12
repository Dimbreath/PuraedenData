-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("Expedition_ItemBuyByName")
GetExpedition_ExpeditionShopTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = GetCommonResource_Line_04Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Item_01 = GetExpedition_ItemBuyUis(ui:GetChild("Item_01"))
  uis.Item_02 = GetExpedition_ItemBuyUis(ui:GetChild("Item_02"))
  uis.root = ui
  return uis
end


