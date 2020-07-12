-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
GetPlotPlay_StoryReviewBanerUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.StoryBaner = GetCommonResource_HeadFrameUis(ui:GetChild("StoryBaner"))
  uis.CharacterNameTxt = ui:GetChild("CharacterNameTxt")
  uis.CharacterWordTxt = ui:GetChild("CharacterWordTxt")
  uis.root = ui
  return uis
end


