-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_HaveCardinfoGrpCompByName")
GetCard_HaveCardinfoGrpCompBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HaveCardinfoGrpComp = GetCard_HaveCardinfoGrpCompUis(ui:GetChild("HaveCardinfoGrpComp"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


