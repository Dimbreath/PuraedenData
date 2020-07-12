-- params : ...
-- function num : 0 , upvalues : _ENV
require("Home_LotteryTipsByName")
require("Home_BtnPanelByName")
require("Home_ResourcesByName")
require("Home_ActivityByName")
require("Home_BackGroundChoiceByName")
GetHome_HomeCtrlUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.CardBtn = ui:GetChild("CardBtn")
  uis.TeamBtn = ui:GetChild("TeamBtn")
  uis.EquipmentBtn = ui:GetChild("EquipmentBtn")
  uis.AdventureBtn = ui:GetChild("AdventureBtn")
  uis.ShopBtn = ui:GetChild("ShopBtn")
  uis.LotteryBtn = ui:GetChild("LotteryBtn")
  uis.TaskBtn = ui:GetChild("TaskBtn")
  uis.HandbookBtn = ui:GetChild("HandbookBtn")
  uis.GuildBtn = ui:GetChild("GuildBtn")
  uis.Top_BagBtn = ui:GetChild("Top_BagBtn")
  uis.Top_MailBtn = ui:GetChild("Top_MailBtn")
  uis.AnnouncementBtn = ui:GetChild("AnnouncementBtn")
  uis.ActorInfoBtn = ui:GetChild("ActorInfoBtn")
  uis.AppointmentBtn = ui:GetChild("AppointmentBtn")
  uis.LotteryTips = GetHome_LotteryTipsUis(ui:GetChild("LotteryTips"))
  uis.Mainhead_04_Grp = ui:GetChild("Mainhead_04_Grp")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.FcWordTxt = ui:GetChild("FcWordTxt")
  uis.FcTxt = ui:GetChild("FcTxt")
  uis.BtnPanel = GetHome_BtnPanelUis(ui:GetChild("BtnPanel"))
  uis.ExpProgressBar = ui:GetChild("ExpProgressBar")
  uis.Gold = GetHome_ResourcesUis(ui:GetChild("Gold"))
  uis.Diamonds = GetHome_ResourcesUis(ui:GetChild("Diamonds"))
  uis.Power = GetHome_ResourcesUis(ui:GetChild("Power"))
  uis.ServerNameTxt = ui:GetChild("ServerNameTxt")
  uis.Activity = GetHome_ActivityUis(ui:GetChild("Activity"))
  uis.CarnivalBtn = ui:GetChild("CarnivalBtn")
  uis.ActivityDungeonBtn = ui:GetChild("ActivityDungeonBtn")
  uis.BackGroundChoice = GetHome_BackGroundChoiceUis(ui:GetChild("BackGroundChoice"))
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


