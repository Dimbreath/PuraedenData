-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
GetArena_OpenUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.RedImage = ui:GetChild("RedImage")
  uis.Decorate_111_Image = ui:GetChild("Decorate_111_Image")
  uis.Decorate_11_Image = ui:GetChild("Decorate_11_Image")
  uis.Decorate_122_Image = ui:GetChild("Decorate_122_Image")
  uis.Decorate_12_Image = ui:GetChild("Decorate_12_Image")
  uis.Decorate_13_Image = ui:GetChild("Decorate_13_Image")
  uis.Decorate_14_Image = ui:GetChild("Decorate_14_Image")
  uis.TimeImage = ui:GetChild("TimeImage")
  uis.TimeImage = ui:GetChild("TimeImage")
  uis.TimeImage = ui:GetChild("TimeImage")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.TouchTxt = ui:GetChild("TouchTxt")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


