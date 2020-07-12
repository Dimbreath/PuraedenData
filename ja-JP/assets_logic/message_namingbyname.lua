-- params : ...
-- function num : 0 , upvalues : _ENV
GetMessage_NamingUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameImage = ui:GetChild("NameImage")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.RandomNameBtn = ui:GetChild("RandomNameBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


