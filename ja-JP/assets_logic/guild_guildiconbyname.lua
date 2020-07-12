-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_GuildIconUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.GuildIconLoader = ui:GetChild("GuildIconLoader")
  uis.root = ui
  return uis
end


