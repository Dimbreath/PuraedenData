-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_ActorHeadByName")
require("ActorInfo_ActorIntroduceByName")
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
GetActorInfo_InfoAssemblyUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ActorHeadGrp = GetActorInfo_ActorHeadUis(ui:GetChild("ActorHeadGrp"))
  uis.ActorIntroduceGrp = GetActorInfo_ActorIntroduceUis(ui:GetChild("ActorIntroduceGrp"))
  uis.NoticeBtn = ui:GetChild("NoticeBtn")
  uis.RechargeBtn = ui:GetChild("RechargeBtn")
  uis.SetBtn = ui:GetChild("SetBtn")
  uis.OutBtn = ui:GetChild("OutBtn")
  uis.ActorNameTxt = ui:GetChild("ActorNameTxt")
  uis.ModifyNameBtn = ui:GetChild("ModifyNameBtn")
  uis.ExpProgressBar = ui:GetChild("ExpProgressBar")
  uis.ExpNumberTxt = ui:GetChild("ExpNumberTxt")
  uis.LvTxt = ui:GetChild("LvTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.GuildImage = GetCommonResource_Base_01Uis(ui:GetChild("GuildImage"))
  uis.GuildImage = GetCommonResource_Base_02Uis(ui:GetChild("GuildImage"))
  uis.GuildImage = ui:GetChild("GuildImage")
  uis.Guild_01_Txt = ui:GetChild("Guild_01_Txt")
  uis.Guild_02_Txt = ui:GetChild("Guild_02_Txt")
  uis.GuildImage = GetCommonResource_Base_01Uis(ui:GetChild("GuildImage"))
  uis.GuildImage = GetCommonResource_Base_02Uis(ui:GetChild("GuildImage"))
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.BattleNumber_01_Txt = ui:GetChild("BattleNumber_01_Txt")
  uis.BattleNumber_02_Txt = ui:GetChild("BattleNumber_02_Txt")
  uis.GuildImage = GetCommonResource_Base_01Uis(ui:GetChild("GuildImage"))
  uis.GuildImage = GetCommonResource_Base_02Uis(ui:GetChild("GuildImage"))
  uis.PlayerIDImage = ui:GetChild("PlayerIDImage")
  uis.PlayerIDTxt = ui:GetChild("PlayerIDTxt")
  uis.PlayerIDNumberTxt = ui:GetChild("PlayerIDNumberTxt")
  uis.CopyBtn = ui:GetChild("CopyBtn")
  uis.root = ui
  return uis
end


