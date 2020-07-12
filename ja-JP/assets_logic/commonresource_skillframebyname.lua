-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_SkillFrameUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.SkillLoader = ui:GetChild("SkillLoader")
  uis.FrameImage = ui:GetChild("FrameImage")
  uis.Frame_01_Image = ui:GetChild("Frame_01_Image")
  uis.Frame_02_Image = ui:GetChild("Frame_02_Image")
  uis.SmallSkillTxt = ui:GetChild("SmallSkillTxt")
  uis.BigSkillTxt = ui:GetChild("BigSkillTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


