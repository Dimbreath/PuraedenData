-- params : ...
-- function num : 0 , upvalues : _ENV
GetFormation_MonsterLoaderUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.ModelLoader = ui:GetChild("ModelLoader")
  uis.root = ui
  return uis
end


