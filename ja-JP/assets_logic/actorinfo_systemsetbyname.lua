-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_SystemSetUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.SetList = ui:GetChild("SetList")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.BattleOutBtn = ui:GetChild("BattleOutBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


