-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_ActorHeadByName")
GetActorInfo_HeadChoiceAssemblyUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.ActorHeadGrp = GetActorInfo_ActorHeadUis(ui:GetChild("ActorHeadGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


