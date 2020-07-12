-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_NoticeWordUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PrepareTxt = ui:GetChild("PrepareTxt")
  uis.PlayingTxt = ui:GetChild("PlayingTxt")
  uis.root = ui
  return uis
end


