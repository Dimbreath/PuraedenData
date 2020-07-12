-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_SoundPlayFillByName")
GetHandBook_SoundPlayBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetHandBook_SoundPlayFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


