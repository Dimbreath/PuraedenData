-- params : ...
-- function num : 0 , upvalues : _ENV
require("Announcement_DateByName")
GetAnnouncement_TitleUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.Date = GetAnnouncement_DateUis(ui:GetChild("Date"))
  uis.root = ui
  return uis
end


