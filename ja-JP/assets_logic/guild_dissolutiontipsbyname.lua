-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_DissolutionTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.Input_01_Image = ui:GetChild("Input_01_Image")
  uis.Input_02_Image = ui:GetChild("Input_02_Image")
  uis.InputNameTxt = ui:GetChild("InputNameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


