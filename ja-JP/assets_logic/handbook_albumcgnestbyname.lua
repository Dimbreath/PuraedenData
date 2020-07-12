-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_AlbumCGByName")
GetHandBook_AlbumCGNestUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AlbumCG = GetHandBook_AlbumCGUis(ui:GetChild("AlbumCG"))
  uis.root = ui
  return uis
end


