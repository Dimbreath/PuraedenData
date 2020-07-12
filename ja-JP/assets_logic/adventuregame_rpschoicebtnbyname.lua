-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_RPSChoiceBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PicLoader = ui:GetChild("PicLoader")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


