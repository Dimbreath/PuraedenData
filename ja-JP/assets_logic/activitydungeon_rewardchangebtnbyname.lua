-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_RewardChangeBtnBgByName")
require("CommonResource_RedDollByName")
require("ActivityDungeon_LineByName")
GetActivityDungeon_RewardChangeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.RewardChangeBtnBg = GetActivityDungeon_RewardChangeBtnBgUis(ui:GetChild("RewardChangeBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.n12 = GetActivityDungeon_LineUis(ui:GetChild("n12"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


