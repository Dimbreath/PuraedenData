-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_ReverseBgMoveByName")
require("Battle_ReverseCardMoveByName")
GetBattle_ReversePicShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BgMove = GetBattle_ReverseBgMoveUis(ui:GetChild("BgMove"))
  uis.CardMove = GetBattle_ReverseCardMoveUis(ui:GetChild("CardMove"))
  uis.root = ui
  return uis
end


