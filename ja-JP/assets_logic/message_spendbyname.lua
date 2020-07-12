-- params : ...
-- function num : 0 , upvalues : _ENV
GetMessage_SpendUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.HaveLoader = ui:GetChild("HaveLoader")
  uis.HaveTxt = ui:GetChild("HaveTxt")
  uis.SpendNameTxt = ui:GetChild("SpendNameTxt")
  uis.SpendLoader = ui:GetChild("SpendLoader")
  uis.SpendTxt = ui:GetChild("SpendTxt")
  uis.SurplusLoader = ui:GetChild("SurplusLoader")
  uis.SurplusTxt = ui:GetChild("SurplusTxt")
  uis.root = ui
  return uis
end


