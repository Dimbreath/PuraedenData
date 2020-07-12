-- params : ...
-- function num : 0 , upvalues : _ENV
GetCardPop_CardGetShowEffectUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.EffcetLoader = ui:GetChild("EffcetLoader")
  uis.SkipBtn = ui:GetChild("SkipBtn")
  uis.root = ui
  return uis
end


