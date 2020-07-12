-- params : ...
-- function num : 0 , upvalues : _ENV
require("Expedition_BuffListByName")
require("Expedition_CardReviveByName")
require("Expedition_ItemBuyListByName")
GetExpedition_EventUIUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.ChoiceBtn = ui:GetChild("ChoiceBtn")
  uis.BuffListGrp = GetExpedition_BuffListUis(ui:GetChild("BuffListGrp"))
  uis.CardReviveGrp = GetExpedition_CardReviveUis(ui:GetChild("CardReviveGrp"))
  uis.ItemBuyListGrp = GetExpedition_ItemBuyListUis(ui:GetChild("ItemBuyListGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


