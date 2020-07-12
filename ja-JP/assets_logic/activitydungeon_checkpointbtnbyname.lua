-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("CommonResource_FrameEffByName")
GetActivityDungeon_CheckpointBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.NameLoader = ui:GetChild("NameLoader")
  uis.LockImage = ui:GetChild("LockImage")
  uis.FrameEff = GetCommonResource_FrameEffUis(ui:GetChild("FrameEff"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


