-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_ChatDecorateByName")
require("Guild_ChatFrameByName")
GetGuild_ChatUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChatDecorateGrp = GetGuild_ChatDecorateUis(ui:GetChild("ChatDecorateGrp"))
  uis.ChatFrameGrp = GetGuild_ChatFrameUis(ui:GetChild("ChatFrameGrp"))
  uis.root = ui
  return uis
end


