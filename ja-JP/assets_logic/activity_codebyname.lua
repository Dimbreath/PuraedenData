-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivity_CodeUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PasteBtn = ui:GetChild("PasteBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.CodeImage = ui:GetChild("CodeImage")
  uis.CodeImage = ui:GetChild("CodeImage")
  uis.CodeTxt = ui:GetChild("CodeTxt")
  uis.root = ui
  return uis
end


