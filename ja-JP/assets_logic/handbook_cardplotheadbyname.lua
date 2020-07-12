-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
require("CommonResource_RedDollByName")
GetHandBook_CardPlotHeadUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HeadLoader = ui:GetChild("HeadLoader")
  uis.Love_02_Image = ui:GetChild("Love_02_Image")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.Image = GetCommonResource_Base_01Uis(ui:GetChild("Image"))
  uis.Image = GetCommonResource_Base_02Uis(ui:GetChild("Image"))
  uis.ProgressTxt = ui:GetChild("ProgressTxt")
  uis.ProgressNumberTxt = ui:GetChild("ProgressNumberTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


