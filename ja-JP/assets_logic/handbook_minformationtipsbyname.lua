-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_02ByName")
GetHandBook_MInformationTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.SetList = ui:GetChild("SetList")
  uis.n10 = GetCommonResource_Line_02Uis(ui:GetChild("n10"))
  uis.root = ui
  return uis
end


