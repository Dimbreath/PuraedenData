-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_AppraisalByName")
GetEquipt_AppraisalWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Appraisal = GetEquipt_AppraisalUis(ui:GetChild("Appraisal"))
  uis.root = ui
  return uis
end


