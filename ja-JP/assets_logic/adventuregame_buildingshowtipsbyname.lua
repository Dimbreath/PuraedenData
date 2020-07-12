-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_BuildingByName")
GetAdventureGame_BuildingShowTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.ProduceTxt = ui:GetChild("ProduceTxt")
  uis.ProduceIconLoader = ui:GetChild("ProduceIconLoader")
  uis.ProduceNumberTxt = ui:GetChild("ProduceNumberTxt")
  uis.CardNumberTxt = ui:GetChild("CardNumberTxt")
  uis.GoBtn = ui:GetChild("GoBtn")
  uis.UnGet_01_Txt = ui:GetChild("UnGet_01_Txt")
  uis.UnGet_02_Txt = ui:GetChild("UnGet_02_Txt")
  uis.BuildingGrp = GetAdventureGame_BuildingUis(ui:GetChild("BuildingGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


