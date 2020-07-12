-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("CommonResource_AssetStripByName")
require("CommonResource_EquiptIconByName")
require("CommonResource_HeadDebrisByName")
require("CommonResource_ItemFrameByName")
require("Bag_EquiptInfoByName")
GetBag_BagWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.BagWindowImage = ui:GetChild("BagWindowImage")
  uis.BagWindowImage = ui:GetChild("BagWindowImage")
  uis.BagWindowImage = ui:GetChild("BagWindowImage")
  uis.BagWindowImage = GetCommonResource_Line_04Uis(ui:GetChild("BagWindowImage"))
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.ItemBtn = ui:GetChild("ItemBtn")
  uis.MaterialBtn = ui:GetChild("MaterialBtn")
  uis.FragmentBtn = ui:GetChild("FragmentBtn")
  uis.EquipmentBtn = ui:GetChild("EquipmentBtn")
  uis.BagWindowGrp = ui:GetChild("BagWindowGrp")
  uis.EquiotIcon = GetCommonResource_EquiptIconUis(ui:GetChild("EquiotIcon"))
  uis.HeadDebrisGrp = GetCommonResource_HeadDebrisUis(ui:GetChild("HeadDebrisGrp"))
  uis.ItemFrameGrp = GetCommonResource_ItemFrameUis(ui:GetChild("ItemFrameGrp"))
  uis.CancleBtn = ui:GetChild("CancleBtn")
  uis.UseBtn = ui:GetChild("UseBtn")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.ItemNameTxt = ui:GetChild("ItemNameTxt")
  uis.ItemList = ui:GetChild("ItemList")
  uis.EquiptInfoGrp = GetBag_EquiptInfoUis(ui:GetChild("EquiptInfoGrp"))
  uis.EquiptImage = ui:GetChild("EquiptImage")
  uis.EquiptTxt = ui:GetChild("EquiptTxt")
  uis.HaveGrp = ui:GetChild("HaveGrp")
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.NothingTxt = ui:GetChild("NothingTxt")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.NothingGrp = ui:GetChild("NothingGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


