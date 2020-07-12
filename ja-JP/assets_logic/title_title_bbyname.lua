-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("CommonResource_Line_03ByName")
GetTitle_Title_BUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Line_04Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Line_03Uis(ui:GetChild("DecorateImage"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.NothingTxt = ui:GetChild("NothingTxt")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.NothingGrp = ui:GetChild("NothingGrp")
  uis.TitleList = ui:GetChild("TitleList")
  uis.AllAttributeBtn = ui:GetChild("AllAttributeBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


