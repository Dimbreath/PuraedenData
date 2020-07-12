-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_GuildBossHeadLimitUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.GuildBossImage1 = ui:GetChild("GuildBossImage1")
  uis.GuildBossImage2 = ui:GetChild("GuildBossImage2")
  uis.root = ui
  return uis
end


