-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_ContentUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.BadgeTipsList = ui:GetChild("BadgeTipsList")
  uis.AnimationLoader = ui:GetChild("AnimationLoader")
  uis.TalkImage = ui:GetChild("TalkImage")
  uis.AnimationTxt = ui:GetChild("AnimationTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


