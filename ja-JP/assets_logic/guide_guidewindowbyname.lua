-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guide_HandByName")
require("Guide_WordByName")
GetGuide_GuideWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Hand = GetGuide_HandUis(ui:GetChild("Hand"))
  uis.WordGrp = GetGuide_WordUis(ui:GetChild("WordGrp"))
  uis.WrodGrp = ui:GetChild("WrodGrp")
  uis.root = ui
  return uis
end


