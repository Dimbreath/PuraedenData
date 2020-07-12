-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_AlbumChoiceBtnBgByName")
require("CommonResource_RedDollByName")
GetHandBook_AlbumChoiceBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AlbumChoiceBtnBg = GetHandBook_AlbumChoiceBtnBgUis(ui:GetChild("AlbumChoiceBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


