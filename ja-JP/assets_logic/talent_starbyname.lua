-- params : ...
-- function num : 0 , upvalues : _ENV
GetTalent_StarUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Star_001_Btn = ui:GetChild("Star_001_Btn")
  uis.Star_002_Btn = ui:GetChild("Star_002_Btn")
  uis.Star_003_Btn = ui:GetChild("Star_003_Btn")
  uis.root = ui
  return uis
end


