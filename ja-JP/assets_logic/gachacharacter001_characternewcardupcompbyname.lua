-- params : ...
-- function num : 0 , upvalues : _ENV
require("GachaCharacter001_CharacterNewCardUpPicByName")
GetGachaCharacter001_CharacterNewCardUpCompUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardPicLoader = GetGachaCharacter001_CharacterNewCardUpPicUis(ui:GetChild("CardPicLoader"))
  uis.ShadowImage = ui:GetChild("ShadowImage")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.Card_01_Btn = ui:GetChild("Card_01_Btn")
  uis.root = ui
  return uis
end


