-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_RenameUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.NameImage = ui:GetChild("NameImage")
  uis.NameImage = ui:GetChild("NameImage")
  uis.InputNameTxt = ui:GetChild("InputNameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.SpendImage = ui:GetChild("SpendImage")
  uis.SpendLoader = ui:GetChild("SpendLoader")
  uis.SpendTxt = ui:GetChild("SpendTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


