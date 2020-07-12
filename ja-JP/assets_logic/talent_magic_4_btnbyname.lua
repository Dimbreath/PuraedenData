-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_SelectEffectByName")
GetTalent_Magic_4_BtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.SelectEffect = GetTalent_SelectEffectUis(ui:GetChild("SelectEffect"))
  uis.LockImage = ui:GetChild("LockImage")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


