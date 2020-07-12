-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("Expedition_ChoiceDifficultyByName")
GetExpedition_ChoiceDifficultyWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.ChoiceDifficultyGrp = GetExpedition_ChoiceDifficultyUis(ui:GetChild("ChoiceDifficultyGrp"))
  uis.root = ui
  return uis
end


