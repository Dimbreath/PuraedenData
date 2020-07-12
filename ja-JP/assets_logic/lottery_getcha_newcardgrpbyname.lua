-- params : ...
-- function num : 0 , upvalues : _ENV
require("GachaCharacter001_CharacterFreshCompByName")
GetLottery_GetCha_NewCardGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CharacterFreshComp = GetGachaCharacter001_CharacterFreshCompUis(ui:GetChild("CharacterFreshComp"))
  uis.OneTimeBtn = ui:GetChild("OneTimeBtn")
  uis.TenTimeBtn = ui:GetChild("TenTimeBtn")
  uis.WordImage = ui:GetChild("WordImage")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


