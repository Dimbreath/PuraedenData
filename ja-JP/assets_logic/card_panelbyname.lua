-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_LevelGrpByName")
require("Card_StageGrpByName")
require("Card_SkillGrpByName")
require("Card_StarGrpByName")
GetCard_PanelUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.LevelGrp = GetCard_LevelGrpUis(ui:GetChild("LevelGrp"))
  uis.StageGrp = GetCard_StageGrpUis(ui:GetChild("StageGrp"))
  uis.SkillGrp = GetCard_SkillGrpUis(ui:GetChild("SkillGrp"))
  uis.StarGrp = GetCard_StarGrpUis(ui:GetChild("StarGrp"))
  uis.LevelBtn = ui:GetChild("LevelBtn")
  uis.StageBtn = ui:GetChild("StageBtn")
  uis.StarBtn = ui:GetChild("StarBtn")
  uis.SkillBtn = ui:GetChild("SkillBtn")
  uis.PanelGrp = ui:GetChild("PanelGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


