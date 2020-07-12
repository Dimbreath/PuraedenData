-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_DetailsGrpByName")
GetHandBook_DetailsGrpNestUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DetailsGrp = GetHandBook_DetailsGrpUis(ui:GetChild("DetailsGrp"))
  uis.root = ui
  return uis
end


