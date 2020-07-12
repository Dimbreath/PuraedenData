-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
require("CommonResource_HeadFrameByName")
GetExpedition_CardHeadUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChoiceGrp = GetCommonResource_FrameEffUis(ui:GetChild("ChoiceGrp"))
  uis.HeadFrameGrp = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrameGrp"))
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.BattleNameTxt = ui:GetChild("BattleNameTxt")
  uis.BattelNumberTxt = ui:GetChild("BattelNumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


