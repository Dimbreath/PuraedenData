-- params : ...
-- function num : 0 , upvalues : _ENV
GetBattle_TalkUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TalkTxt = ui:GetChild("TalkTxt")
  uis.root = ui
  return uis
end


