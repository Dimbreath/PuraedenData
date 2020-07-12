-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_ExperienceProgressFillByName")
GetBattle_ExperienceProgressBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetBattle_ExperienceProgressFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


