-- params : ...
-- function num : 0 , upvalues : _ENV
GetLand_LandUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PicLoader = ui:GetChild("PicLoader")
  uis.VersionTxt = ui:GetChild("VersionTxt")
  uis.IDTxt = ui:GetChild("IDTxt")
  uis.LogoImage = ui:GetChild("LogoImage")
  uis.TouchBtn = ui:GetChild("TouchBtn")
  uis.SetBtn = ui:GetChild("SetBtn")
  uis.root = ui
  return uis
end


