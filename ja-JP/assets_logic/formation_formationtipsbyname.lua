-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
GetFormation_FormationTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TipsImage = ui:GetChild("TipsImage")
  uis.HeadFrameGrp = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrameGrp"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.ContentList = ui:GetChild("ContentList")
  uis.CardCultivateBtn = ui:GetChild("CardCultivateBtn")
  uis.EquiptCultivateBtn = ui:GetChild("EquiptCultivateBtn")
  uis.EquiptList = ui:GetChild("EquiptList")
  uis.root = ui
  return uis
end


