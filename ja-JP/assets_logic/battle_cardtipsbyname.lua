-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_CardTipsPictureByName")
require("Battle_CardQByName")
require("Battle_FloatTipsByName")
GetBattle_CardTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardTipsPictureGrp = GetBattle_CardTipsPictureUis(ui:GetChild("CardTipsPictureGrp"))
  uis.CardQGrp = GetBattle_CardQUis(ui:GetChild("CardQGrp"))
  uis.OneGrp = GetBattle_FloatTipsUis(ui:GetChild("OneGrp"))
  uis.TwoGrp = GetBattle_FloatTipsUis(ui:GetChild("TwoGrp"))
  uis.ThreeGrp = GetBattle_FloatTipsUis(ui:GetChild("ThreeGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


