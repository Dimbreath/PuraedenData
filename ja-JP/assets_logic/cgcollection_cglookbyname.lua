-- params : ...
-- function num : 0 , upvalues : _ENV
GetCGcollection_CGLookUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.CommentList = ui:GetChild("CommentList")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


