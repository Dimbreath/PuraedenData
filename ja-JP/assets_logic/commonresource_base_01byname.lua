-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_Base_01Uis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.root = ui
  return uis
end


