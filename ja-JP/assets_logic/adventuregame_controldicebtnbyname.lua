-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
require("AdventureGame_DiceByName")
GetAdventureGame_ControlDiceBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChoiceGrp = GetCommonResource_FrameEffUis(ui:GetChild("ChoiceGrp"))
  uis.n5 = GetAdventureGame_DiceUis(ui:GetChild("n5"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


