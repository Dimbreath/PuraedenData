-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_ItemBuyTipsByName")
GetMessage_ItemBuyTipsWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ItemBuyTipsGrp = GetMessage_ItemBuyTipsUis(ui:GetChild("ItemBuyTipsGrp"))
  uis.root = ui
  return uis
end


