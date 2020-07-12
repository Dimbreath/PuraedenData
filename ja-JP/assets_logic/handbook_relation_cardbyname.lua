-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_CardPictureByName")
GetHandBook_Relation_CardUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Card_01_Grp = GetHandBook_CardPictureUis(ui:GetChild("Card_01_Grp"))
  uis.Card_02_Grp = GetHandBook_CardPictureUis(ui:GetChild("Card_02_Grp"))
  uis.Card_03_Grp = GetHandBook_CardPictureUis(ui:GetChild("Card_03_Grp"))
  uis.Card_04_Grp = GetHandBook_CardPictureUis(ui:GetChild("Card_04_Grp"))
  uis.Card_05_Grp = GetHandBook_CardPictureUis(ui:GetChild("Card_05_Grp"))
  uis.Card_06_Grp = GetHandBook_CardPictureUis(ui:GetChild("Card_06_Grp"))
  uis.root = ui
  return uis
end


