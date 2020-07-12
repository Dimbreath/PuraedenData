-- params : ...
-- function num : 0 , upvalues : _ENV
GetHandBook_MInformationUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.TipsList = ui:GetChild("TipsList")
  uis.PageNumberList = ui:GetChild("PageNumberList")
  uis.root = ui
  return uis
end


