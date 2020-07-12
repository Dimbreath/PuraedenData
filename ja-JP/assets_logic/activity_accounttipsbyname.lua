-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivity_AccountTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.BattleOutBtn = ui:GetChild("BattleOutBtn")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.root = ui
  return uis
end


