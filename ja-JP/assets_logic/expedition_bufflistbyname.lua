-- params : ...
-- function num : 0 , upvalues : _ENV
GetExpedition_BuffListUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.FirstBtn = ui:GetChild("FirstBtn")
  uis.SecondBtn = ui:GetChild("SecondBtn")
  uis.ThirdBtn = ui:GetChild("ThirdBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


