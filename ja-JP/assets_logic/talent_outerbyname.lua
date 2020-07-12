-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_BGGroupByName")
GetTalent_OuterUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BGGroup = GetTalent_BGGroupUis(ui:GetChild("BGGroup"))
  uis.OuterLoader = ui:GetChild("OuterLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


