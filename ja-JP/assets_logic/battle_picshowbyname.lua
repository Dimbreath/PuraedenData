-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BgMoveByName")
require("Battle_CardMoveByName")
GetBattle_PicShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BgMove = GetBattle_BgMoveUis(ui:GetChild("BgMove"))
  uis.CardMove = GetBattle_CardMoveUis(ui:GetChild("CardMove"))
  uis.root = ui
  return uis
end


