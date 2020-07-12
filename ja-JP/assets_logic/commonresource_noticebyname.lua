-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_NoticeWordByName")
GetCommonResource_NoticeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HorselightImage = ui:GetChild("HorselightImage")
  uis.NoticeWordGrp = GetCommonResource_NoticeWordUis(ui:GetChild("NoticeWordGrp"))
  uis.root = ui
  return uis
end


