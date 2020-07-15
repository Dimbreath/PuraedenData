-- params : ...
-- function num : 0 , upvalues : _ENV
require("GachaCharacter001_CharacterNewCardUpPicByName")
GetGachaCharacter001_CharacterNewCardUpCompUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardPicLoader = GetGachaCharacter001_CharacterNewCardUpPicUis(ui:GetChild("CardPicLoader"))
  uis.ShadowImage = ui:GetChild("ShadowImage")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.Card_A1_Btn = ui:GetChild("Card_A1_Btn")
  uis.Card_B1_Btn = ui:GetChild("Card_B1_Btn")
  uis.Card_B2_Btn = ui:GetChild("Card_B2_Btn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


