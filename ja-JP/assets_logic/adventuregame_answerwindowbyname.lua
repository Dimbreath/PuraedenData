-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
require("AdventureGame_AnswerGameByName")
GetAdventureGame_AnswerWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.AnswerGrp = GetAdventureGame_AnswerGameUis(ui:GetChild("AnswerGrp"))
  uis.root = ui
  return uis
end


