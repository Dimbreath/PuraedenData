-- params : ...
-- function num : 0 , upvalues : _ENV
GetTalent_SpendUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Spend_A_Image = ui:GetChild("Spend_A_Image")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.root = ui
  return uis
end


