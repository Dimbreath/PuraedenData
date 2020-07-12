-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_LockByName")
GetBattle_SystemBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.LockGrp = GetBattle_LockUis(ui:GetChild("LockGrp"))
  uis.buttonCtr = ui:GetController("button")
  uis.lockCtr = ui:GetController("lock")
  uis.root = ui
  return uis
end


