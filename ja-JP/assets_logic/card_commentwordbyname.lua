-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_CommentWordUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CardNameTxt = ui:GetChild("CardNameTxt")
  uis.CommentWordTxt = ui:GetChild("CommentWordTxt")
  uis.AppreciateBtn = ui:GetChild("AppreciateBtn")
  uis.root = ui
  return uis
end


