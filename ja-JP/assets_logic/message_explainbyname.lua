-- params : ...
-- function num : 0 , upvalues : _ENV
GetMessage_ExplainUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.ContentList = ui:GetChild("ContentList")
  uis.ExplainTxt = ui:GetChild("ExplainTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.ExplainGrp = ui:GetChild("ExplainGrp")
  uis.root = ui
  return uis
end


