-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_SoundControlUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.SoundBtn = ui:GetChild("SoundBtn")
  uis.SoundSlider = ui:GetChild("SoundSlider")
  uis.root = ui
  return uis
end


