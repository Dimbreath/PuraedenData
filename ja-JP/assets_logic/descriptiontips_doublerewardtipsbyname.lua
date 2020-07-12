-- params : ...
-- function num : 0 , upvalues : _ENV
GetDescriptionTips_DoubleRewardTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TipsImage = ui:GetChild("TipsImage")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.DoubleNumberTxt = ui:GetChild("DoubleNumberTxt")
  uis.Time_01_Txt = ui:GetChild("Time_01_Txt")
  uis.Time_02_Txt = ui:GetChild("Time_02_Txt")
  uis.TimeWordTxtTxt = ui:GetChild("TimeWordTxtTxt")
  uis.root = ui
  return uis
end


