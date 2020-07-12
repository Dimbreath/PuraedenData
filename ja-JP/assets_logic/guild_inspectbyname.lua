-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_InspectUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.InspectTipsList = ui:GetChild("InspectTipsList")
  uis.AllNoBtn = ui:GetChild("AllNoBtn")
  uis.AllYesBtn = ui:GetChild("AllYesBtn")
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.AnimationLoader = ui:GetChild("AnimationLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


