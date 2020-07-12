-- params : ...
-- function num : 0 , upvalues : _ENV
GetMessage_CenterTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.centertipsTxt = ui:GetChild("centertipsTxt")
  uis.CenterTipsGrp = ui:GetChild("CenterTipsGrp")
  uis.root = ui
  return uis
end


