-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_ExpFillByName")
GetActorInfo_ExpBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetActorInfo_ExpFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


