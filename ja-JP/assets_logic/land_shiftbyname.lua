-- params : ...
-- function num : 0 , upvalues : _ENV
GetLand_ShiftUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ChoiceImage = ui:GetChild("ChoiceImage")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.CancelBtn = ui:GetChild("CancelBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.IDTxt = ui:GetChild("IDTxt")
  uis.PassWordTxt = ui:GetChild("PassWordTxt")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.InputIDTxt = ui:GetChild("InputIDTxt")
  uis.InputPassWordTxt = ui:GetChild("InputPassWordTxt")
  uis.root = ui
  return uis
end


