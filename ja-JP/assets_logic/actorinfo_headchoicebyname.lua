-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_HeadChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.HeadChoiceTxt = ui:GetChild("HeadChoiceTxt")
  uis.HeadList = ui:GetChild("HeadList")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


