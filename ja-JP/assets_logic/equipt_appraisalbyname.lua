-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
GetEquipt_AppraisalUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.CleanUpList = ui:GetChild("CleanUpList")
  uis.Spend_A_Image = ui:GetChild("Spend_A_Image")
  uis.Spend_A_Loader = ui:GetChild("Spend_A_Loader")
  uis.Spend_A_Txt = ui:GetChild("Spend_A_Txt")
  uis.Spend_B_Image = ui:GetChild("Spend_B_Image")
  uis.Spend_B_Loader = ui:GetChild("Spend_B_Loader")
  uis.Spend_B_Txt = ui:GetChild("Spend_B_Txt")
  uis.CleanBtn = ui:GetChild("CleanBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.CleanUp_01_Txt = ui:GetChild("CleanUp_01_Txt")
  uis.AnimationLoader = ui:GetChild("AnimationLoader")
  uis.NothingGrp = ui:GetChild("NothingGrp")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


