-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_TenTimeResultTips_AByName")
require("AdventureGame_TenTimeResultTips_BByName")
GetAdventureGame_TenTimeResultUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.titlenameTxt = ui:GetChild("titlenameTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.Tips_A_Grp = GetAdventureGame_TenTimeResultTips_AUis(ui:GetChild("Tips_A_Grp"))
  uis.Tips_B_Grp = GetAdventureGame_TenTimeResultTips_BUis(ui:GetChild("Tips_B_Grp"))
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


