-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_EquiptIconByName")
require("CommonResource_HeadDebrisByName")
require("CommonResource_ItemFrameByName")
require("CommonResource_HeadFrameByName")
GetCommonResource_AllItemIconUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.EquiotIcon = GetCommonResource_EquiptIconUis(ui:GetChild("EquiotIcon"))
  uis.HeadDebrisGrp = GetCommonResource_HeadDebrisUis(ui:GetChild("HeadDebrisGrp"))
  uis.ItemFrameGrp = GetCommonResource_ItemFrameUis(ui:GetChild("ItemFrameGrp"))
  uis.HeadFrame = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrame"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


