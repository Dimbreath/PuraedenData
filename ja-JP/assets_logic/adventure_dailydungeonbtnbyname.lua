-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_RedDollByName")
require("Adventure_DailyDungeonTipsByName")
GetAdventure_DailyDungeonBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameImage = ui:GetChild("NameImage")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.DailyDungeonTips = GetAdventure_DailyDungeonTipsUis(ui:GetChild("DailyDungeonTips"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


