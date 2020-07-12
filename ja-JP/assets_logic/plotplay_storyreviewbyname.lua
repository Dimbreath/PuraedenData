-- params : ...
-- function num : 0 , upvalues : _ENV
GetPlotPlay_StoryReviewUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.confirmBtn = ui:GetChild("confirmBtn")
  uis.itemList = ui:GetChild("itemList")
  uis.StoryReviewGrp = ui:GetChild("StoryReviewGrp")
  uis.root = ui
  return uis
end


