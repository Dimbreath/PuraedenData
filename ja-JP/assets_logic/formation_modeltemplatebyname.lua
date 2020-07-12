-- params : ...
-- function num : 0 , upvalues : _ENV
require("Formation_MonsterLoaderByName")
require("Formation_TalkByName")
GetFormation_ModelTemplateUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.MonsterLoader = GetFormation_MonsterLoaderUis(ui:GetChild("MonsterLoader"))
  uis.OrderImage = ui:GetChild("OrderImage")
  uis.OrderMyTxt = ui:GetChild("OrderMyTxt")
  uis.OrderEnemyTxt = ui:GetChild("OrderEnemyTxt")
  uis.Talk = GetFormation_TalkUis(ui:GetChild("Talk"))
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


