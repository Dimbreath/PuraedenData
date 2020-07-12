-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_CleanUpChoiceByName")
require("CommonResource_Line_03ByName")
GetEquipt_CleanUpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CleanUpChoice = GetEquipt_CleanUpChoiceUis(ui:GetChild("CleanUpChoice"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Line_03Uis(ui:GetChild("DecorateImage"))
  uis.EquiptList = ui:GetChild("EquiptList")
  uis.AllChoiceBtn = ui:GetChild("AllChoiceBtn")
  uis.AllChoiceTxt = ui:GetChild("AllChoiceTxt")
  uis.DecomposeBtn = ui:GetChild("DecomposeBtn")
  uis.WareHouseGrp = ui:GetChild("WareHouseGrp")
  uis.root = ui
  return uis
end


