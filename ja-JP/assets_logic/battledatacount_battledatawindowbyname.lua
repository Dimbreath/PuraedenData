-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
require("BattleDataCount_BattleDataByName")
GetBattleDataCount_BattleDataWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.RedImage = ui:GetChild("RedImage")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.BattleDataComp = GetBattleDataCount_BattleDataUis(ui:GetChild("BattleDataComp"))
  uis.root = ui
  return uis
end


