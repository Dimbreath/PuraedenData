-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_DetailedContentByName")
require("Card_DetailedContentOtherByName")
GetCard_CardInfoUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DetailedContentGrp = GetCard_DetailedContentUis(ui:GetChild("DetailedContentGrp"))
  uis.DetailedContentOtherGrp = GetCard_DetailedContentOtherUis(ui:GetChild("DetailedContentOtherGrp"))
  uis.CommentBtn = ui:GetChild("CommentBtn")
  uis.root = ui
  return uis
end


