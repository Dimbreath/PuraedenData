-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
GetCommonResource_ExpeditionHeadUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HeadFrameGrp = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrameGrp"))
  uis.root = ui
  return uis
end


