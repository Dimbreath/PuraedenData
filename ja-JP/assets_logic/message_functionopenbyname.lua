-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
require("CommonResource_ResultDiamondLeftByName")
require("CommonResource_ResultDiamondRightByName")
GetMessage_FunctionOpenUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.RedImage = ui:GetChild("RedImage")
  uis.Title_01_Image = ui:GetChild("Title_01_Image")
  uis.Title_02_Image = ui:GetChild("Title_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = GetCommonResource_ResultDiamondLeftUis(ui:GetChild("Decorate_05_Image"))
  uis.Decorate_06_Image = GetCommonResource_ResultDiamondRightUis(ui:GetChild("Decorate_06_Image"))
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.BookLoader = ui:GetChild("BookLoader")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.TouchTxt = ui:GetChild("TouchTxt")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


