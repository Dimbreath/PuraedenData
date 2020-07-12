-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Carnival_TaskByName")
require("Carnival_TipsByName")
GetCarnival_CarnivalMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.TaskGrp = GetCarnival_TaskUis(ui:GetChild("TaskGrp"))
  uis.TipsGrp = GetCarnival_TipsUis(ui:GetChild("TipsGrp"))
  uis.root = ui
  return uis
end


