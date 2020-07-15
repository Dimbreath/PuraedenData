-- params : ...
-- function num : 0 , upvalues : _ENV
require("Land_PactWordByName")
GetLand_PactUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Explain_A_Btn = ui:GetChild("Explain_A_Btn")
  uis.Explain_B_Btn = ui:GetChild("Explain_B_Btn")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.ChoiceImage = ui:GetChild("ChoiceImage")
  uis.ChoiceBtn = ui:GetChild("ChoiceBtn")
  uis.ChoiceWordTxt = ui:GetChild("ChoiceWordTxt")
  uis.CancelBtn = ui:GetChild("CancelBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.PactWordA = GetLand_PactWordUis(ui:GetChild("PactWordA"))
  uis.PactWordB = GetLand_PactWordUis(ui:GetChild("PactWordB"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


