-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_NoticeByName")
GetCommonResource_NoticeWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n0 = GetCommonResource_NoticeUis(ui:GetChild("n0"))
  uis.root = ui
  return uis
end


