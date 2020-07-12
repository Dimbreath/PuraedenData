-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
GetArena_RecordTipsGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.GuildImage = GetCommonResource_Base_01Uis(ui:GetChild("GuildImage"))
  uis.GuildImage = GetCommonResource_Base_02Uis(ui:GetChild("GuildImage"))
  uis.BattleTxt = ui:GetChild("BattleTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.DataBtn = ui:GetChild("DataBtn")
  uis.RePlayBtn = ui:GetChild("RePlayBtn")
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.HeadImage = ui:GetChild("HeadImage")
  uis.HeadLoader = ui:GetChild("HeadLoader")
  uis.HeadGrp = ui:GetChild("HeadGrp")
  uis.LvNumTxt = ui:GetChild("LvNumTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.SuccessImage = ui:GetChild("SuccessImage")
  uis.DefenseSuccessImage = ui:GetChild("DefenseSuccessImage")
  uis.BattleSuccessImage = ui:GetChild("BattleSuccessImage")
  uis.LoseImage = ui:GetChild("LoseImage")
  uis.DefenseLoseImage = ui:GetChild("DefenseLoseImage")
  uis.BattleLoseImage = ui:GetChild("BattleLoseImage")
  uis.StateGrp = ui:GetChild("StateGrp")
  uis.RecordTipsGrp = ui:GetChild("RecordTipsGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


