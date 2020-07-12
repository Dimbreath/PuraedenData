-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_SpendByName")
GetMessage_SpendTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.ChoiceBtn = ui:GetChild("ChoiceBtn")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.BattleOutBtn = ui:GetChild("BattleOutBtn")
  uis.SpendA = GetMessage_SpendUis(ui:GetChild("SpendA"))
  uis.SpendB = GetMessage_SpendUis(ui:GetChild("SpendB"))
  uis.root = ui
  return uis
end


