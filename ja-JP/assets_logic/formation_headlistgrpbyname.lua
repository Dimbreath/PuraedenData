-- params : ...
-- function num : 0 , upvalues : _ENV
require("Formation_Division_AByName")
GetFormation_HeadListGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.BattleStartBtn = ui:GetChild("BattleStartBtn")
  uis.ArrayBtn = ui:GetChild("ArrayBtn")
  uis.Division_A = GetFormation_Division_AUis(ui:GetChild("Division_A"))
  uis.ExpeditionList = ui:GetChild("ExpeditionList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


