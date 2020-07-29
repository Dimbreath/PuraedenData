-- params : ...
-- function num : 0 , upvalues : _ENV
require("Announcement_ArrowByName")
GetAnnouncement_AnnouncementUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.BtnList = ui:GetChild("BtnList")
  uis.ContentList = ui:GetChild("ContentList")
  uis.ImageList = ui:GetChild("ImageList")
  uis.Up = GetAnnouncement_ArrowUis(ui:GetChild("Up"))
  uis.Down = GetAnnouncement_ArrowUis(ui:GetChild("Down"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


