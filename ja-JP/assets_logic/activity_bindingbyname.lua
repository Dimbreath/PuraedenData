-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivity_BindingUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PassWordBtn = ui:GetChild("PassWordBtn")
  uis.SDKBtn = ui:GetChild("SDKBtn")
  uis.GetBtn = ui:GetChild("GetBtn")
  uis.AccountTipsBtn = ui:GetChild("AccountTipsBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


