-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_BadgeChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.BadgeTipsList = ui:GetChild("BadgeTipsList")
  uis.root = ui
  return uis
end


