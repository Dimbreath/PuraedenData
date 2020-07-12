-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("HandBook_IntimacyPanelByName")
GetHandBook_IntimacyUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.PictureLoader = ui:GetChild("PictureLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.IntimacyPanelGep = GetHandBook_IntimacyPanelUis(ui:GetChild("IntimacyPanelGep"))
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.CardNameLoader = ui:GetChild("CardNameLoader")
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.CVImage = ui:GetChild("CVImage")
  uis.CVNameLoader = ui:GetChild("CVNameLoader")
  uis.root = ui
  return uis
end


