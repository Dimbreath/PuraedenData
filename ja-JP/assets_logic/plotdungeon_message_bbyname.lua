-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
GetPlotDungeon_Message_BUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HeadFrame = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrame"))
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.Word_02_Txt = ui:GetChild("Word_02_Txt")
  uis.root = ui
  return uis
end


