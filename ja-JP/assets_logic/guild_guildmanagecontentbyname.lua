-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_JournalByName")
require("Guild_MemberByName")
require("Guild_InspectByName")
GetGuild_GuildManageContentUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.JournalGrp = GetGuild_JournalUis(ui:GetChild("JournalGrp"))
  uis.MemberGrp = GetGuild_MemberUis(ui:GetChild("MemberGrp"))
  uis.InspectGrp = GetGuild_InspectUis(ui:GetChild("InspectGrp"))
  uis.JournalBtn = ui:GetChild("JournalBtn")
  uis.MemberBtn = ui:GetChild("MemberBtn")
  uis.InspectBtn = ui:GetChild("InspectBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


