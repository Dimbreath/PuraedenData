-- params : ...
-- function num : 0 , upvalues : _ENV
require("Activity_CakeTalkByName")
require("Activity_CardItemByName")
GetActivity_CakeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CakeTalk = GetActivity_CakeTalkUis(ui:GetChild("CakeTalk"))
  uis.CardItem_01_Grp = GetActivity_CardItemUis(ui:GetChild("CardItem_01_Grp"))
  uis.CardItem_02_Grp = GetActivity_CardItemUis(ui:GetChild("CardItem_02_Grp"))
  uis.CardItem_03_Grp = GetActivity_CardItemUis(ui:GetChild("CardItem_03_Grp"))
  uis.CardItem_04_Grp = GetActivity_CardItemUis(ui:GetChild("CardItem_04_Grp"))
  uis.root = ui
  return uis
end


