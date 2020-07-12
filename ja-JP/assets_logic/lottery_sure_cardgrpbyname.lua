-- params : ...
-- function num : 0 , upvalues : _ENV
require("GachaCharacter001_CharacterSureCompByName")
GetLottery_Sure_CardGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CharacterSureComp = GetGachaCharacter001_CharacterSureCompUis(ui:GetChild("CharacterSureComp"))
  uis.TenTimeBtn = ui:GetChild("TenTimeBtn")
  uis.root = ui
  return uis
end


