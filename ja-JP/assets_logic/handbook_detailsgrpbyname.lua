-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_DetailsIconGrpByName")
GetHandBook_DetailsGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DetailsIconGrp = GetHandBook_DetailsIconGrpUis(ui:GetChild("DetailsIconGrp"))
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.LockTxt = ui:GetChild("LockTxt")
  uis.LockGrp = ui:GetChild("LockGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


