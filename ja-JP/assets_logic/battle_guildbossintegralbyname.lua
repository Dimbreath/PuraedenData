-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_GuildBossIntegralUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.IntegralTxt = ui:GetChild("IntegralTxt")
  uis.IntegralNumberTxt = ui:GetChild("IntegralNumberTxt")
  uis.root = ui
  return uis
end


