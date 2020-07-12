-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_NumberFillByName")
GetTalent_NumberBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetTalent_NumberFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


