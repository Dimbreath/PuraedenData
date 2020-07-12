-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_SpendByName")
GetTalent_AttributeUpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.LvTxt = ui:GetChild("LvTxt")
  uis.AttributeList = ui:GetChild("AttributeList")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.Spend_001 = GetTalent_SpendUis(ui:GetChild("Spend_001"))
  uis.Spend_002 = GetTalent_SpendUis(ui:GetChild("Spend_002"))
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


