-- params : ...
-- function num : 0 , upvalues : _ENV
require("GachaCharacter001_CharacterNewCardUpCompByName")
GetLottery_GetCha_NewCardUpGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CharacterNewCardUpComp = GetGachaCharacter001_CharacterNewCardUpCompUis(ui:GetChild("CharacterNewCardUpComp"))
  uis.OneTimeBtn = ui:GetChild("OneTimeBtn")
  uis.TenTimeBtn = ui:GetChild("TenTimeBtn")
  uis.SpecialOneTimeBtn = ui:GetChild("SpecialOneTimeBtn")
  uis.WordImage = ui:GetChild("WordImage")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.SpecialOneTimeImage = ui:GetChild("SpecialOneTimeImage")
  uis.root = ui
  return uis
end


