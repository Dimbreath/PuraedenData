-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("Title_TitlePicByName")
GetTitle_ShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Line_03Uis(ui:GetChild("DecorateImage"))
  uis.UseImage = ui:GetChild("UseImage")
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.GetATxt = ui:GetChild("GetATxt")
  uis.GetBTxt = ui:GetChild("GetBTxt")
  uis.AttributeTxt = ui:GetChild("AttributeTxt")
  uis.AttributeList = ui:GetChild("AttributeList")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


