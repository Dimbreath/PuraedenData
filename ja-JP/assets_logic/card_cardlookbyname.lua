-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_LevelEffectByName")
GetCard_CardLookUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.Empty = GetCommonResource_LevelEffectUis(ui:GetChild("Empty"))
  uis.TouchBtn = ui:GetChild("TouchBtn")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.RotateBtn = ui:GetChild("RotateBtn")
  uis.SwitchBtn = ui:GetChild("SwitchBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


