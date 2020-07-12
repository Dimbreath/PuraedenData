-- params : ...
-- function num : 0 , upvalues : _ENV
require("Title_TitlePicByName")
GetTitle_TitleChoiceBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.UseImage = ui:GetChild("UseImage")
  uis.LockImage = ui:GetChild("LockImage")
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


