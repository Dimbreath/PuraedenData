-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_RedDollByName")
GetTitle_TitlePicUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PicLoader = ui:GetChild("PicLoader")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


