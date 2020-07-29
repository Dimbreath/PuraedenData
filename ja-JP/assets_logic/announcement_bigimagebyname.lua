-- params : ...
-- function num : 0 , upvalues : _ENV
require("Announcement_DateByName")
GetAnnouncement_BigImageUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ImageLoader = ui:GetChild("ImageLoader")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.Date = GetAnnouncement_DateUis(ui:GetChild("Date"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


