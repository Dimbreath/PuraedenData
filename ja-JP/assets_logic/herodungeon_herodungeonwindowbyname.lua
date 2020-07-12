-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("HeroDungeon_CardQByName")
require("HeroDungeon_BookComponentByName")
GetHeroDungeon_HeroDungeonWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.CardQ = GetHeroDungeon_CardQUis(ui:GetChild("CardQ"))
  uis.BookComponent = GetHeroDungeon_BookComponentUis(ui:GetChild("BookComponent"))
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.root = ui
  return uis
end


