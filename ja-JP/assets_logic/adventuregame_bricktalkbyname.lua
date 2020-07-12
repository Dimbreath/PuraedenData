-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
GetAdventureGame_BrickTalkUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.talkGrp = ui:GetChild("talkGrp")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.TalkTxt = ui:GetChild("TalkTxt")
  uis.root = ui
  return uis
end


