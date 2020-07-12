-- params : ...
-- function num : 0 , upvalues : _ENV
require("Mail_MailDetailedByName")
GetMail_MailDetailedNestUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.MailDetailed = GetMail_MailDetailedUis(ui:GetChild("MailDetailed"))
  uis.root = ui
  return uis
end


