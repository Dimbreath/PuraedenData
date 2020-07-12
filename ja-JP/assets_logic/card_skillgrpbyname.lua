-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_StarImageByName")
require("Card_SkillEffectGrpByName")
GetCard_SkillGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.StarImage = GetCommonResource_StarImageUis(ui:GetChild("StarImage"))
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.DecorateGrp = ui:GetChild("DecorateGrp")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.SkillEffectGrp = GetCard_SkillEffectGrpUis(ui:GetChild("SkillEffectGrp"))
  uis.root = ui
  return uis
end


