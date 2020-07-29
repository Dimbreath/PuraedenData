-- params : ...
-- function num : 0 , upvalues : _ENV
require("Announcement_LabelTipsByName")
require("CommonResource_RedDollByName")
GetAnnouncement_LabelBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ButtonIconLoader = ui:GetChild("ButtonIconLoader")
  uis.LabelTips = GetAnnouncement_LabelTipsUis(ui:GetChild("LabelTips"))
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


