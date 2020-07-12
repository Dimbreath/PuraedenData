-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_PlayerHeadByName")
require("Guild_TipsInfo_03ByName")
require("Guild_TipsInfo_02ByName")
require("Guild_ChatStatusByName")
GetGuild_PlayerInfoUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.PlayerHeadGrp = GetGuild_PlayerHeadUis(ui:GetChild("PlayerHeadGrp"))
  uis.CardList = ui:GetChild("CardList")
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.FunctionList = ui:GetChild("FunctionList")
  uis.BattleNumberGrp = GetGuild_TipsInfo_03Uis(ui:GetChild("BattleNumberGrp"))
  uis.WeekGrp = GetGuild_TipsInfo_02Uis(ui:GetChild("WeekGrp"))
  uis.ChatStatus = GetGuild_ChatStatusUis(ui:GetChild("ChatStatus"))
  uis.root = ui
  return uis
end


