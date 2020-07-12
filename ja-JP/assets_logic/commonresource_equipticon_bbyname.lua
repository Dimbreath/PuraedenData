-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
require("CommonResource_RedDollByName")
GetCommonResource_EquiptIcon_BUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.FrameEffGrp = GetCommonResource_FrameEffUis(ui:GetChild("FrameEffGrp"))
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.Icon_01_Image = ui:GetChild("Icon_01_Image")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.StarList = ui:GetChild("StarList")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.c4Ctr = ui:GetController("c4")
  uis.root = ui
  return uis
end


