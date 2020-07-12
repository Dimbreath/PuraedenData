-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
require("Battle_BossPicByName")
require("Battle_BossCVByName")
require("Battle_BossNameByName")
GetBattle_BossTips_9Uis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.RedImage = ui:GetChild("RedImage")
  uis.BossPic = GetBattle_BossPicUis(ui:GetChild("BossPic"))
  uis.BossCV = GetBattle_BossCVUis(ui:GetChild("BossCV"))
  uis.BossName = GetBattle_BossNameUis(ui:GetChild("BossName"))
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


