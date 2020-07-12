-- params : ...
-- function num : 0 , upvalues : _ENV
require("GachaCharacter001_CharacterCardCompByName")
GetLottery_GetCha_CardGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CharacterCardComp = GetGachaCharacter001_CharacterCardCompUis(ui:GetChild("CharacterCardComp"))
  uis.OneTimeBtn = ui:GetChild("OneTimeBtn")
  uis.TenTimeBtn = ui:GetChild("TenTimeBtn")
  uis.SpecialOneTimeBtn = ui:GetChild("SpecialOneTimeBtn")
  uis.WordImage = ui:GetChild("WordImage")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.SpecialOneTimeImage = ui:GetChild("SpecialOneTimeImage")
  uis.root = ui
  return uis
end


