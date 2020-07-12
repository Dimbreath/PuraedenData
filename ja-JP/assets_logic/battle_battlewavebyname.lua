-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_WaveBottomByName")
GetBattle_BattleWaveUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = GetBattle_WaveBottomUis(ui:GetChild("Decorate_01_Image"))
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.WaveNumberTxt = ui:GetChild("WaveNumberTxt")
  uis.root = ui
  return uis
end


