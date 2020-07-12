-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivity_CardItemUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CakeLoader = ui:GetChild("CakeLoader")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.BlankBtn = ui:GetChild("BlankBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


