-- params : ...
-- function num : 0 , upvalues : _ENV
GetArena_RewardFractionGrpUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Tips_01_Txt = ui:GetChild("Tips_01_Txt")
  uis.Tips_02_Txt = ui:GetChild("Tips_02_Txt")
  uis.Tips_03_Txt = ui:GetChild("Tips_03_Txt")
  uis.Tips_04_Txt = ui:GetChild("Tips_04_Txt")
  uis.FractionTxt = ui:GetChild("FractionTxt")
  uis.FractionList = ui:GetChild("FractionList")
  uis.root = ui
  return uis
end


