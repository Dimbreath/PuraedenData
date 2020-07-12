-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_BossNameUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.root = ui
  return uis
end


