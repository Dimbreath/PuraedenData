-- params : ...
-- function num : 0 , upvalues : _ENV
GetShare_InformationUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.LogoImage = ui:GetChild("LogoImage")
  uis.CodeImage = ui:GetChild("CodeImage")
  uis.ShotBtn = ui:GetChild("ShotBtn")
  uis.root = ui
  return uis
end


