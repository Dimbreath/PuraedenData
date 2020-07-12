-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_LevelItemUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.PlusImage = ui:GetChild("PlusImage")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.EXPTxt = ui:GetChild("EXPTxt")
  uis.EXPNumberTxt = ui:GetChild("EXPNumberTxt")
  uis.root = ui
  return uis
end


