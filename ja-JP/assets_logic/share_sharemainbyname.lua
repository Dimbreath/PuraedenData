-- params : ...
-- function num : 0 , upvalues : _ENV
require("Share_ShotByName")
GetShare_ShareMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Shot = GetShare_ShotUis(ui:GetChild("Shot"))
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.FacebookBtn = ui:GetChild("FacebookBtn")
  uis.LineBtn = ui:GetChild("LineBtn")
  uis.PreserveBtn = ui:GetChild("PreserveBtn")
  uis.TwitterBtn = ui:GetChild("TwitterBtn")
  uis.root = ui
  return uis
end


