-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Task_TaskPanelByName")
require("Task_TaskRateByName")
GetTask_TaskUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.DecorateGrp = ui:GetChild("DecorateGrp")
  uis.TaskDetailedList = ui:GetChild("TaskDetailedList")
  uis.TaskPanelGrp = GetTask_TaskPanelUis(ui:GetChild("TaskPanelGrp"))
  uis.TaskRateGrp = GetTask_TaskRateUis(ui:GetChild("TaskRateGrp"))
  uis.root = ui
  return uis
end


