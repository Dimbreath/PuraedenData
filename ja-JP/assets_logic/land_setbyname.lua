-- params : ...
-- function num : 0 , upvalues : _ENV
GetLand_SetUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.MoveBtn = ui:GetChild("MoveBtn")
  uis.SDKBtn = ui:GetChild("SDKBtn")
  uis.NoticeBtn = ui:GetChild("NoticeBtn")
  uis.AgreementBtn = ui:GetChild("AgreementBtn")
  uis.RepairBtn = ui:GetChild("RepairBtn")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


