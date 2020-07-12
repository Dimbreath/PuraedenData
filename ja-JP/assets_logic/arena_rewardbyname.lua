-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_RewardChangePanelGrpByName")
GetArena_RewardUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.RewardChangePanelGrp = GetArena_RewardChangePanelGrpUis(ui:GetChild("RewardChangePanelGrp"))
  uis.RewardTxt = ui:GetChild("RewardTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.ButtonBtn = ui:GetChild("ButtonBtn")
  uis.RewardGrp = ui:GetChild("RewardGrp")
  uis.root = ui
  return uis
end


