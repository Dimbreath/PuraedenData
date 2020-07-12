-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
GetCard_DetailedContentOtherUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CVImage = ui:GetChild("CVImage")
  uis.CVNameLoader = ui:GetChild("CVNameLoader")
  uis.GuildImage = GetCommonResource_Base_01Uis(ui:GetChild("GuildImage"))
  uis.GuildImage = GetCommonResource_Base_02Uis(ui:GetChild("GuildImage"))
  uis.JuQingTxt = ui:GetChild("JuQingTxt")
  uis.JuQingNumberTxt = ui:GetChild("JuQingNumberTxt")
  uis.GuildImage = GetCommonResource_Base_01Uis(ui:GetChild("GuildImage"))
  uis.GuildImage = GetCommonResource_Base_02Uis(ui:GetChild("GuildImage"))
  uis.RelationTxt = ui:GetChild("RelationTxt")
  uis.RelationNameTxt = ui:GetChild("RelationNameTxt")
  uis.RelationLevelTxt = ui:GetChild("RelationLevelTxt")
  uis.ChangeCardBtn = ui:GetChild("ChangeCardBtn")
  uis.root = ui
  return uis
end


