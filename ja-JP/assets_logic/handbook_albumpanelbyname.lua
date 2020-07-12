-- params : ...
-- function num : 0 , upvalues : _ENV
GetHandBook_AlbumPanelUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.MuJianBtn = ui:GetChild("MuJianBtn")
  uis.ShouXinBtn = ui:GetChild("ShouXinBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


