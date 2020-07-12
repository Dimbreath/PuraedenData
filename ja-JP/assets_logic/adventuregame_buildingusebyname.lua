-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_BuildingByName")
require("AdventureGame_BuildingUseTipsByName")
GetAdventureGame_BuildingUseUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.FunctionBtn = ui:GetChild("FunctionBtn")
  uis.BuildImage = ui:GetChild("BuildImage")
  uis.BuildImage = ui:GetChild("BuildImage")
  uis.BuildingNameTxt = ui:GetChild("BuildingNameTxt")
  uis.BuildingGrp = GetAdventureGame_BuildingUis(ui:GetChild("BuildingGrp"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.RateTxt = ui:GetChild("RateTxt")
  uis.RateIconLoader = ui:GetChild("RateIconLoader")
  uis.RateNumberTxt = ui:GetChild("RateNumberTxt")
  uis.GetTxt = ui:GetChild("GetTxt")
  uis.GetIconLoader = ui:GetChild("GetIconLoader")
  uis.GetNumberTxt = ui:GetChild("GetNumberTxt")
  uis.TotalTxt = ui:GetChild("TotalTxt")
  uis.TotalIconLoader = ui:GetChild("TotalIconLoader")
  uis.TotalNumberTxt = ui:GetChild("TotalNumberTxt")
  uis.Card_03_Grp = GetAdventureGame_BuildingUseTipsUis(ui:GetChild("Card_03_Grp"))
  uis.Card_02_Grp = GetAdventureGame_BuildingUseTipsUis(ui:GetChild("Card_02_Grp"))
  uis.Card_01_Grp = GetAdventureGame_BuildingUseTipsUis(ui:GetChild("Card_01_Grp"))
  uis.root = ui
  return uis
end


