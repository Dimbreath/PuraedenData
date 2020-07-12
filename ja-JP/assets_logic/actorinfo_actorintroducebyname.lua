-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_ActorIntroduceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ActorIntroduceTxt = ui:GetChild("ActorIntroduceTxt")
  uis.root = ui
  return uis
end


