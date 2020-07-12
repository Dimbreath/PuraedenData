-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_EquiptScreenByName")
require("CommonResource_Line_03ByName")
require("Equipt_EquiptChangeBtnPanelByName")
GetEquipt_EquiptChangeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.EquiptScreenGrp = GetEquipt_EquiptScreenUis(ui:GetChild("EquiptScreenGrp"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Line_03Uis(ui:GetChild("DecorateImage"))
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.EquiptList = ui:GetChild("EquiptList")
  uis.EquiptChangeBtnPanelGrp = GetEquipt_EquiptChangeBtnPanelUis(ui:GetChild("EquiptChangeBtnPanelGrp"))
  uis.SortBtn = ui:GetChild("SortBtn")
  uis.OrderBtn = ui:GetChild("OrderBtn")
  uis.AllChoiceBtn = ui:GetChild("AllChoiceBtn")
  uis.AllChoiceTxt = ui:GetChild("AllChoiceTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


