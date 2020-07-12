-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_SkillDescribeGrpByName")
GetCard_SkillDescribeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.SkillDescribeGrp = GetCard_SkillDescribeGrpUis(ui:GetChild("SkillDescribeGrp"))
  uis.root = ui
  return uis
end


