-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_CardLabelByName")
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
GetCard_MessageGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.One = GetCommonResource_CardLabelUis(ui:GetChild("One"))
  uis.Two = GetCommonResource_CardLabelUis(ui:GetChild("Two"))
  uis.Three = GetCommonResource_CardLabelUis(ui:GetChild("Three"))
  uis.BattleImage = GetCommonResource_Base_01Uis(ui:GetChild("BattleImage"))
  uis.BattleImage = GetCommonResource_Base_02Uis(ui:GetChild("BattleImage"))
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.BattleOneTxt = ui:GetChild("BattleOneTxt")
  uis.BattleTwoTxt = ui:GetChild("BattleTwoTxt")
  uis.root = ui
  return uis
end


