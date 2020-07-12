-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_RecordTipsBtnBgByName")
GetArena_RecordTipsBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.RecordTipsBtnBg = GetArena_RecordTipsBtnBgUis(ui:GetChild("RecordTipsBtnBg"))
  uis.Number_01_Loader = ui:GetChild("Number_01_Loader")
  uis.Number_01_Txt = ui:GetChild("Number_01_Txt")
  uis.SweepBtn = ui:GetChild("SweepBtn")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


