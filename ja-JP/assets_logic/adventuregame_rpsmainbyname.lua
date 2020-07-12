-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
GetAdventureGame_RPSMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.PicImage = ui:GetChild("PicImage")
  uis.ALoader = ui:GetChild("ALoader")
  uis.BLoader = ui:GetChild("BLoader")
  uis.AnimationLoader = ui:GetChild("AnimationLoader")
  uis.DrawImage = ui:GetChild("DrawImage")
  uis.WinAImage = ui:GetChild("WinAImage")
  uis.WinBImage = ui:GetChild("WinBImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


