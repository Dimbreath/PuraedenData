-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_DoubleRewardByName")
require("CommonResource_AssetsButtonByName")
GetCommonResource_AssetStripUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.FunctionNameTxt = ui:GetChild("FunctionNameTxt")
  uis.BackBtn = ui:GetChild("BackBtn")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.ExplainBtn = ui:GetChild("ExplainBtn")
  uis.Double_01_Grp = GetCommonResource_DoubleRewardUis(ui:GetChild("Double_01_Grp"))
  uis.Double_02_Grp = GetCommonResource_DoubleRewardUis(ui:GetChild("Double_02_Grp"))
  uis.Double_03_Grp = GetCommonResource_DoubleRewardUis(ui:GetChild("Double_03_Grp"))
  uis.FunctionNameGrp = ui:GetChild("FunctionNameGrp")
  uis.Assets_01_Grp = GetCommonResource_AssetsButtonUis(ui:GetChild("Assets_01_Grp"))
  uis.Assets_02_Grp = GetCommonResource_AssetsButtonUis(ui:GetChild("Assets_02_Grp"))
  uis.Assets_03_Grp = GetCommonResource_AssetsButtonUis(ui:GetChild("Assets_03_Grp"))
  uis.Assets_04_Grp = GetCommonResource_AssetsButtonUis(ui:GetChild("Assets_04_Grp"))
  uis.CloseAssetGrp = ui:GetChild("CloseAssetGrp")
  uis.root = ui
  return uis
end


