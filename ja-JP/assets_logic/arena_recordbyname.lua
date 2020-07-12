-- params : ...
-- function num : 0 , upvalues : _ENV
GetArena_RecordUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.RecordTxt = ui:GetChild("RecordTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.ButtonBtn = ui:GetChild("ButtonBtn")
  uis.BattleInformationList = ui:GetChild("BattleInformationList")
  uis.root = ui
  return uis
end


