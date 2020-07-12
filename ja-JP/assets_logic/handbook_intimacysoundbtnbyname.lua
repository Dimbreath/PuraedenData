-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_SoundPlayingByName")
require("HandBook_SoundStripByName")
GetHandBook_IntimacySoundBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.LockImage = ui:GetChild("LockImage")
  uis.UnLockImage = ui:GetChild("UnLockImage")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.SoundPlayingGrp = GetHandBook_SoundPlayingUis(ui:GetChild("SoundPlayingGrp"))
  uis.SoundStrip = GetHandBook_SoundStripUis(ui:GetChild("SoundStrip"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


