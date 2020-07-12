-- params : ...
-- function num : 0 , upvalues : _ENV
GetTalent_EffectUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.root = ui
  return uis
end


