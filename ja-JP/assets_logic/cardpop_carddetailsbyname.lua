-- params : ...
-- function num : 0 , upvalues : _ENV
require("CardPop_InformationByName")
require("CommonResource_SkillFrameByName")
require("CommonResource_AssetStripByName")
GetCardPop_CardDetailsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BuleImage = ui:GetChild("BuleImage")
  uis.PurpleImage = ui:GetChild("PurpleImage")
  uis.OrangeImage = ui:GetChild("OrangeImage")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.InformationGrp = GetCardPop_InformationUis(ui:GetChild("InformationGrp"))
  uis.SkillMessage_01_Grp = GetCommonResource_SkillFrameUis(ui:GetChild("SkillMessage_01_Grp"))
  uis.SkillMessage_02_Grp = GetCommonResource_SkillFrameUis(ui:GetChild("SkillMessage_02_Grp"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.TipsImage = ui:GetChild("TipsImage")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


