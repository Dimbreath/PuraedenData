-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("CommonResource_Line_02ByName")
require("Talent_SelectEffectByName")
GetTalent_StarUpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Line_03Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Line_02Uis(ui:GetChild("DecorateImage"))
  uis.IdleEffect = GetTalent_SelectEffectUis(ui:GetChild("IdleEffect"))
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.StarUpAttributeList = ui:GetChild("StarUpAttributeList")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.SpendImage = ui:GetChild("SpendImage")
  uis.Spend_01_Loader = ui:GetChild("Spend_01_Loader")
  uis.Spend_01_Txt = ui:GetChild("Spend_01_Txt")
  uis.SpendImage = ui:GetChild("SpendImage")
  uis.Spend_02_Loader = ui:GetChild("Spend_02_Loader")
  uis.Spend_02_Txt = ui:GetChild("Spend_02_Txt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


