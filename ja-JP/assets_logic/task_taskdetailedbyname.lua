-- params : ...
-- function num : 0 , upvalues : _ENV
GetTask_TaskDetailedUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.Complete_01_Txt = ui:GetChild("Complete_01_Txt")
  uis.Complete_02_Txt = ui:GetChild("Complete_02_Txt")
  uis.Complete_03_Txt = ui:GetChild("Complete_03_Txt")
  uis.ItemList = ui:GetChild("ItemList")
  uis.JumpBtn = ui:GetChild("JumpBtn")
  uis.functionBtn = ui:GetChild("functionBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


