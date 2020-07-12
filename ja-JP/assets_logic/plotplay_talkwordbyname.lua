-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotPlay_CharacterNameByName")
GetPlotPlay_TalkWordUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.talkGrp = ui:GetChild("talkGrp")
  uis.arowGrp = ui:GetChild("arowGrp")
  uis.CardName_01_Grp = GetPlotPlay_CharacterNameUis(ui:GetChild("CardName_01_Grp"))
  uis.talkTxt = ui:GetChild("talkTxt")
  uis.root = ui
  return uis
end


