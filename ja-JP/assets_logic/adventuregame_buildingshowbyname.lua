-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_BuildingShowUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BuildinglList = ui:GetChild("BuildinglList")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.GetAllBtn = ui:GetChild("GetAllBtn")
  uis.root = ui
  return uis
end


