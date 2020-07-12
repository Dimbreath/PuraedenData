-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Title_Title_AByName")
require("Title_Title_BByName")
require("Title_Title_CByName")
GetTitle_TitleWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.Title_A = GetTitle_Title_AUis(ui:GetChild("Title_A"))
  uis.Title_B = GetTitle_Title_BUis(ui:GetChild("Title_B"))
  uis.Title_C = GetTitle_Title_CUis(ui:GetChild("Title_C"))
  uis.root = ui
  return uis
end


