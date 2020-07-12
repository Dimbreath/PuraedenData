-- params : ...
-- function num : 0 , upvalues : _ENV
GetLand_WordExplainUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WrodList = ui:GetChild("WrodList")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


