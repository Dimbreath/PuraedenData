-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_SelectEffectByName")
GetTalent_Star_003_BtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.IdleEffect = GetTalent_SelectEffectUis(ui:GetChild("IdleEffect"))
  uis.SelectEffect = GetTalent_SelectEffectUis(ui:GetChild("SelectEffect"))
  uis.LockImage = ui:GetChild("LockImage")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


