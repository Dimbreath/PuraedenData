-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadDebrisByName")
GetHeroDungeon_SweepCardGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.IconImage = ui:GetChild("IconImage")
  uis.HeadDebrisGrp = GetCommonResource_HeadDebrisUis(ui:GetChild("HeadDebrisGrp"))
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.Number_01_Txt = ui:GetChild("Number_01_Txt")
  uis.Number_02_Txt = ui:GetChild("Number_02_Txt")
  uis.Time_01_Txt = ui:GetChild("Time_01_Txt")
  uis.Time_02_Txt = ui:GetChild("Time_02_Txt")
  uis.DefaultBtn = ui:GetChild("DefaultBtn")
  uis.SweepCardGrp = ui:GetChild("SweepCardGrp")
  uis.root = ui
  return uis
end


