-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattleDataCount_BattleDataUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.BattleDataModelList = ui:GetChild("BattleDataModelList")
  uis.Colour_01_Txt = ui:GetChild("Colour_01_Txt")
  uis.Colour_02_Txt = ui:GetChild("Colour_02_Txt")
  uis.root = ui
  return uis
end


