-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_SwitchUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Switch_A_Btn = ui:GetChild("Switch_A_Btn")
  uis.Switch_B_Btn = ui:GetChild("Switch_B_Btn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


