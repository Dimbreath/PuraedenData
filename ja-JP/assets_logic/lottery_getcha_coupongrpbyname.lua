-- params : ...
-- function num : 0 , upvalues : _ENV
require("GachaCharacter001_CharacterCouponCompByName")
GetLottery_GetCha_CouponGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CharacterCouponComp = GetGachaCharacter001_CharacterCouponCompUis(ui:GetChild("CharacterCouponComp"))
  uis.BackImage = ui:GetChild("BackImage")
  uis.OneTimeBtn = ui:GetChild("OneTimeBtn")
  uis.TenTimeBtn = ui:GetChild("TenTimeBtn")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.root = ui
  return uis
end


