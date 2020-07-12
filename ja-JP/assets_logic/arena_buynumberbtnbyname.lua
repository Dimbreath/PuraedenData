-- params : ...
-- function num : 0 , upvalues : _ENV
GetArena_BuyNumberBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.SurplusTxt = ui:GetChild("SurplusTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


