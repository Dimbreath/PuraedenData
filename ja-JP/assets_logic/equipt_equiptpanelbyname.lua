-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_EquiptDetailedByName")
require("Equipt_AppraisalWindowByName")
require("Equipt_EquiptChangeByName")
require("Equipt_CleanUpByName")
require("Equipt_EquiptPanelFrameByName")
require("CommonResource_EquiptIcon_BByName")
require("CommonResource_EquiptIcon_AByName")
GetEquipt_EquiptPanelUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.EquiptDetailedGrp = GetEquipt_EquiptDetailedUis(ui:GetChild("EquiptDetailedGrp"))
  uis.AppraisalGrp = GetEquipt_AppraisalWindowUis(ui:GetChild("AppraisalGrp"))
  uis.EquiptChangeGrp = GetEquipt_EquiptChangeUis(ui:GetChild("EquiptChangeGrp"))
  uis.CleanUpGrp = GetEquipt_CleanUpUis(ui:GetChild("CleanUpGrp"))
  uis.EquiptPanelFrame = GetEquipt_EquiptPanelFrameUis(ui:GetChild("EquiptPanelFrame"))
  uis.EquiptDetailedBtn = ui:GetChild("EquiptDetailedBtn")
  uis.EquiptChangeBtn = ui:GetChild("EquiptChangeBtn")
  uis.AppraisalBtn = ui:GetChild("AppraisalBtn")
  uis.CleanUpBtn = ui:GetChild("CleanUpBtn")
  uis.WeaponGrp = GetCommonResource_EquiptIcon_BUis(ui:GetChild("WeaponGrp"))
  uis.ClothesGrp = GetCommonResource_EquiptIcon_BUis(ui:GetChild("ClothesGrp"))
  uis.NecklaceGrp = GetCommonResource_EquiptIcon_AUis(ui:GetChild("NecklaceGrp"))
  uis.RingGrp = GetCommonResource_EquiptIcon_AUis(ui:GetChild("RingGrp"))
  uis.EquiptIconGrp = ui:GetChild("EquiptIconGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


