-- params : ...
-- function num : 0 , upvalues : _ENV
GetLottery_Gacha002_OneBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Number_01_Loader = ui:GetChild("Number_01_Loader")
  uis.Number_01_Txt = ui:GetChild("Number_01_Txt")
  uis.FreeNumberTxt = ui:GetChild("FreeNumberTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


