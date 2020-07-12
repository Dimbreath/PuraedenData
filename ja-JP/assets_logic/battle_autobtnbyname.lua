-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_LockByName")
GetBattle_AutoBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.LockGrp = GetBattle_LockUis(ui:GetChild("LockGrp"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.lockCtr = ui:GetController("lock")
  uis.root = ui
  return uis
end


