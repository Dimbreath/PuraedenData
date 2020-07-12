-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_FloatTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.PlayerLevelTxt = ui:GetChild("PlayerLevelTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


