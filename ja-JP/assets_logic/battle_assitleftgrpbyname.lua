-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_AssistGrpByName")
GetBattle_AssitLeftGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n0 = GetBattle_AssistGrpUis(ui:GetChild("n0"))
  uis.root = ui
  return uis
end


