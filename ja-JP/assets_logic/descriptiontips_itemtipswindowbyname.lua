-- params : ...
-- function num : 0 , upvalues : _ENV
require("DescriptionTips_ItemTipsByName")
GetDescriptionTips_ItemTipsWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ItemTipsGrp = GetDescriptionTips_ItemTipsUis(ui:GetChild("ItemTipsGrp"))
  uis.root = ui
  return uis
end


