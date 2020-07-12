-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_EmojiChoiceByName")
GetGuild_ChatFrameUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.IconImage = ui:GetChild("IconImage")
  uis.ChatList = ui:GetChild("ChatList")
  uis.SwitchBtn = ui:GetChild("SwitchBtn")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.InputTxt = ui:GetChild("InputTxt")
  uis.EmojiBtn = ui:GetChild("EmojiBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.EmojiChoiceGrp = GetGuild_EmojiChoiceUis(ui:GetChild("EmojiChoiceGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


