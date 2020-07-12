-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_StoryPlotChapterBtnBgByName")
require("HandBook_StoryLineByName")
GetHandBook_StoryPlotChapterBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.StoryPlotChapterBtnBg = GetHandBook_StoryPlotChapterBtnBgUis(ui:GetChild("StoryPlotChapterBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.StoryLine = GetHandBook_StoryLineUis(ui:GetChild("StoryLine"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


