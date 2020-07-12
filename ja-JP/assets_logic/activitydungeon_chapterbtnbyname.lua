-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityDungeon_ChapterBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PicLoader = ui:GetChild("PicLoader")
  uis.LockImage = ui:GetChild("LockImage")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


