-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_DifficultyBgByName")
GetActivityDungeon_DifficultyBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DifficultyBg = GetActivityDungeon_DifficultyBgUis(ui:GetChild("DifficultyBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.lockCtr = ui:GetController("lock")
  uis.root = ui
  return uis
end


