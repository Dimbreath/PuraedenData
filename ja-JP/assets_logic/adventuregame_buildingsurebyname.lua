-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
require("AdventureGame_ArrowNumberByName")
GetAdventureGame_BuildingSureUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.CancelBtn = ui:GetChild("CancelBtn")
  uis.ExplainTxt = ui:GetChild("ExplainTxt")
  uis.Head_A_Grp = GetCommonResource_HeadFrameUis(ui:GetChild("Head_A_Grp"))
  uis.RateWord_A_Txt = ui:GetChild("RateWord_A_Txt")
  uis.RateNumber_A_Txt = ui:GetChild("RateNumber_A_Txt")
  uis.ArrowNumberGrp = GetAdventureGame_ArrowNumberUis(ui:GetChild("ArrowNumberGrp"))
  uis.Head_B_Grp = GetCommonResource_HeadFrameUis(ui:GetChild("Head_B_Grp"))
  uis.root = ui
  return uis
end


