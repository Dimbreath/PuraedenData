-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
require("CommonResource_Line_03ByName")
require("CommonResource_HeadFrameByName")
require("CommonResource_QualityGrpCompByName")
GetGift_StageCardBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChoiceEff = GetCommonResource_FrameEffUis(ui:GetChild("ChoiceEff"))
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.HeadFrame = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrame"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.ItemList = ui:GetChild("ItemList")
  uis.StageA = GetCommonResource_QualityGrpCompUis(ui:GetChild("StageA"))
  uis.StageB = GetCommonResource_QualityGrpCompUis(ui:GetChild("StageB"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


