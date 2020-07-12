-- params : ...
-- function num : 0 , upvalues : _ENV
UIMgr = (CS.UIManager).Singleton
WinResConfig = {
TestWindow = {name = "TestWindow", package = "Test", comName = "TestWindow", hideBelow = true}
, 
LoadingWindow = {name = "LoadingWindow", package = "Loading", comName = "LoadingWindow", hideBelow = true, notReopen = true}
, 
MsgWaitingWindow = {name = "MsgWaitingWindow", package = "Loading", comName = "NetCheck", hideBelow = false, notReopen = true}
, 
BattleUIWindow = {name = "BattleUIWindow", package = "Battle", comName = "BattleUIWindow", hideBelow = true, notReopen = true}
, 
MonthWindow = {name = "MonthWindow", package = "Shop", comName = "MonthWindow", hideBelow = false, notReopen = true}
, 
LoginWindow = {name = "LoginWindow", package = "Land", comName = "Land", hideBelow = true, notReopen = true}
, 
LoginSetWindow = {name = "LoginSetWindow", package = "Land", comName = "SetWindow", hideBelow = false, notReopen = true}
, 
ShiftWindow = {name = "ShiftWindow", package = "Land", comName = "ShiftWindow", hideBelow = false, notReopen = true}
, 
PactWindow = {name = "PactWindow", package = "Land", comName = "PactWindow", hideBelow = false, notReopen = true}
, 
WordExplainWindow = {name = "WordExplainWindow", package = "Land", comName = "WordExplainWindow", hideBelow = false, notReopen = true}
, 
CurrencyWindow = {name = "CurrencyWindow", package = "Land", comName = "CurrencyWindow", hideBelow = false, notReopen = true}
, 
HomeWindow = {name = "HomeWindow", package = "Home", comName = "HomeWindow", hideBelow = true}
, 
CardWindow = {name = "CardWindow", package = "Card", comName = "CardWindow", hideBelow = true}
, 
MailWindow = {name = "MailWindow", package = "Mail", comName = "Mail", hideBelow = true}
, 
LotteryWindow = {name = "LotteryWindow", package = "Lottery", comName = "Lottery", hideBelow = true}
, 
LotteryMainWindow = {name = "LotteryMainWindow", package = "Lottery", comName = "Lottery", hideBelow = true}
, 
LotteryRewardWindow = {name = "LotteryRewardWindow", package = "Lottery", comName = "LotteryReward", hideBelow = false, notReopen = true}
, 
LotteryProbabilityWindow = {name = "LotteryProbabilityWindow", package = "Lottery", comName = "Probability", hideBelow = false, notReopen = true}
, 
CardChoiceWindow = {name = "CardChoiceWindow", package = "Card", comName = "CardChoice", hideBelow = false}
, 
CardListWindow = {name = "CardListWindow", package = "Card", comName = "CardList", hideBelow = true}
, 
FormationWindow = {name = "FormationWindow", package = "Formation", comName = "FormationWindow", hideBelow = true}
, 
PlotPlayWindow = {name = "PlotPlayWindow", package = "PlotDungeon", comName = "PlotPlayWindow", hideBelow = true}
, 
PlotDetailWindow = {name = "PlotDetailWindow", package = "PlotDungeon", comName = "PlotDetailWindow", hideBelow = false, notReopen = true}
, 
RewardDisplayWindow = {name = "RewardDisplayWindow", package = "Message", comName = "popPanelWindow", hideBelow = false}
, 
ClearingWindow = {name = "ClearingWindow", package = "PlotDungeon", comName = "ClearingPanelWindow", hideBelow = false}
, 
CenterTipsWindow = {name = "CenterTipsWindow", package = "Message", comName = "CenterTips", hideBelow = false}
, 
BattleUpWindow = {name = "BattleUpWindow", package = "CommonResource", comName = "BattleUp", hideBelow = false, notReopen = true}
, 
AdventureWindow = {name = "AdventureWindow", package = "Adventure", comName = "AdventureWindow", hideBelow = true}
, 
BattleSettleWindow = {name = "BattleSettleWindow", package = "Battle", comName = "BattleSettlementWin", hideBelow = false, notReopen = true}
, 
PlotPlayPanelWindow = {name = "PlotPlayPanelWindow", package = "PlotPlay", comName = "PlotPlayPanel", hideBelow = false, notReopen = true}
, 
StoryReviewWindow = {name = "StoryReviewWindow", package = "PlotPlay", comName = "StoryReviewWindow", hideBelow = false}
, 
ConfirmWindow = {name = "ConfirmWindow", package = "Message", comName = "popPanelsmallWindow", hideBelow = false, notReopen = true}
, 
BagWindow = {name = "BagWindow", package = "Bag", comName = "BagWindow", hideBelow = true}
, 
ExchangeWindow = {name = "ExchangeWindow", package = "GetWay", comName = "Exchange", hideBelow = false}
, 
GetWayWindow = {name = "GetWayWindow", package = "GetWay", comName = "GetWayWindow", hideBelow = false}
, 
HeroDungeonWindow = {name = "HeroDungeonWindow", package = "HeroDungeon", comName = "HeroDungeonWindow", hideBelow = true}
, 
HeroDungeonMainWindow = {name = "HeroDungeonMainWindow", package = "HeroDungeon", comName = "HeroDungeonMainWindow", hideBelow = true}
, 
ArenaWindow = {name = "ArenaWindow", package = "Arena", comName = "Arena", hideBelow = true}
, 
ArenaRecordWindow = {name = "ArenaRecordWindow", package = "Arena", comName = "RecordWindow", hideBelow = false}
, 
ArenaRewardWindow = {name = "ArenaRewardWindow", package = "Arena", comName = "RewardWindow", hideBelow = false}
, 
ArenaRankWindow = {name = "ArenaRankWindow", package = "Arena", comName = "RankingWindow", hideBelow = false}
, 
ArenaBattleDataWindow = {name = "ArenaBattleDataWindow", package = "Arena", comName = "BattleData", hideBelow = false}
, 
ArenaBattleWinWindow = {name = "ArenaBattleWinWindow", package = "Battle", comName = "ArenaBattleWin", hideBelow = false, notReopen = true}
, 
ArenaBattleFailWindow = {name = "ArenaBattleFailWindow", package = "Battle", comName = "ArenaBattleFail", hideBelow = false, notReopen = true}
, 
StageUpPropertyWindow = {name = "StageUpPropertyWindow", package = "Card", comName = "StageUpProperty", hideBelow = false}
, 
SkillGetGrpWindow = {name = "SkillGetGrpWindow", package = "Card", comName = "SkillGetGrp", hideBelow = false}
, 
CardGetWindow = {name = "CardGetWindow", package = "Message", comName = "CardGet", hideBelow = true}
, 
CardGetShowWindow = {name = "CardGetShowWindow", package = "CardPop", comName = "CardGetShow", hideBelow = false, notReopen = true}
, 
PiceGetShowWindow = {name = "PiceGetShowWindow", package = "CardPop", comName = "PiceGetShow", hideBelow = true, notReopen = true}
, 
RewardShowWindow = {name = "RewardShowWindow", package = "Message", comName = "RewardShow", hideBelow = false}
, 
FastSweepWindow = {name = "FastSweepWindow", package = "HeroDungeon", comName = "SpeedSweepWindow", hideBelow = false}
, 
DailyDungeonChapterListWindow = {name = "DailyDungeonChapterListWindow", package = "DailyDungeon", comName = "ChapterList", hideBelow = true}
, 
DailyDungeonDifficultyWindow = {name = "DailyDungeonDifficultyWindow", package = "DailyDungeon", comName = "BattleDifficulty", hideBelow = true}
, 
DailyDungeonPassRewardWindow = {name = "DailyDungeonPassRewardWindow", package = "DailyDungeon", comName = "ChoiceWife", hideBelow = true, notReopen = true}
, 
DailyDungeonSweepWindow = {name = "DailyDungeonSweepWindow", package = "DailyDungeon", comName = "SweepWindow", hideBelow = false, notReopen = true}
, 
BattleSettleFailureWindow = {name = "BattleSettleFailureWindow", package = "Battle", comName = "BattleFailure", hideBelow = false, notReopen = true}
, 
BuyTipsMessageWindow = {name = "BuyTipsMessageWindow", package = "Message", comName = "BuyTipsMessageWindow", hideBelow = false}
, 
ItemTipsWindow = {name = "ItemTipsWindow", package = "DescriptionTips", comName = "ItemTipsWindow", hideBelow = false, notReopen = true}
, 
DoubleRewardTipsWindow = {name = "DoubleRewardTipsWindow", package = "DescriptionTips", comName = "DoubleRewardTipsWindow", hideBelow = false, notReopen = true}
, 
SkillTipsWindow = {name = "SkillTipsWindow", package = "DescriptionTips", comName = "SkillTipsWindow", hideBelow = false, notReopen = true}
, 
BattleDataWindow = {name = "BattleDataWindow", package = "BattleDataCount", comName = "BattleDataWindow", hideBelow = false, notReopen = true}
, 
ShopWindow = {name = "ShopWindow", package = "Shop", comName = "ShopWindow", hideBelow = true}
, 
ShopBuyWindow = {name = "ShopBuyWindow", package = "Shop", comName = "ShopBuyWindow", hideBelow = false}
, 
EquipmentWindow = {name = "EquipmentWindow", package = "Equipt", comName = "Equipt", hideBelow = true}
, 
ExplainWindow = {name = "ExplainWindow", package = "Message", comName = "ExplainWindow", hideBelow = false}
, 
StarUpPropertyWindow = {name = "StarUpPropertyWindow", package = "Card", comName = "StarUpProperty", hideBelow = false}
, 
StageUpEquiptWindow = {name = "StageUpEquiptWindow", package = "Card", comName = "StageUpEquipt", hideBelow = false}
, 
EquiptLevelWindow = {name = "EquiptLevelWindow", package = "Equipt", comName = "EquiptLevelWindow", hideBelow = false}
, 
StarDebrisChangeGrpWindow = {name = "StarDebrisChangeGrpWindow", package = "Card", comName = "StarDebrisChangeGrpWindow", hideBelow = false}
, 
TaskWindow = {name = "TaskWindow", package = "Task", comName = "Task", hideBelow = true}
, 
GuideWindow = {name = "GuideWindow", package = "Guide", comName = "GuideWindow", hideBelow = false}
, 
TowerWindow = {name = "TowerWindow", package = "Tower", comName = "Tower", hideBelow = true}
, 
TowerBattleWindow = {name = "TowerBattleWindow", package = "Battle", comName = "TowerBattleWin", hideBelow = false}
, 
ExpeditionChoiceWindow = {name = "ExpeditionChoiceWindow", package = "Expedition", comName = "ExpeditionChoice", hideBelow = true, notReopen = true}
, 
ExpeditionWindow = {name = "ExpeditionWindow", package = "Expedition", comName = "Expedition", hideBelow = true}
, 
FunctionOpenWindow = {name = "FunctionOpenWindow", package = "Message", comName = "FunctionOpen", hideBelow = false}
, 
ExpeditionEnterWindow = {name = "ExpeditionEnterWindow", package = "Expedition", comName = "ChoiceDifficultyWindow", hideBelow = false, notReopen = true}
, 
ExpeditionEventWindow = {name = "ExpeditionEventWindow", package = "Expedition", comName = "EventUIWindow", hideBelow = false, notReopen = true}
, 
ExpeditionDetailWindow = {name = "ExpeditionDetailWindow", package = "Expedition", comName = "RewardShowWindow", hideBelow = false, notReopen = true}
, 
ItemBuyTipsWindow = {name = "ItemBuyTipsWindow", package = "Message", comName = "ItemBuyTipsWindow", hideBelow = false}
, 
ExpeditionSettleWindow = {name = "ExpeditionSettleWindow", package = "Battle", comName = "ExpeditionBattleWin", hideBelow = false}
, 
ActorInfoWindow = {name = "ActorInfoWindow", package = "ActorInfo", comName = "ActorInfo", hideBelow = true}
, 
HeadChoiceWindow = {name = "HeadChoiceWindow", package = "ActorInfo", comName = "HeadChoiceWindow", hideBelow = false}
, 
TalentMainWindow = {name = "TalentMainWindow", package = "Talent", comName = "TalentMain", hideBelow = true}
, 
TalentStarUpWindow = {name = "TalentStarUpWindow", package = "Talent", comName = "StarUpWindow", hideBelow = false}
, 
TalentStarUpAttrWindow = {name = "TalentStarUpAttrWindow", package = "Talent", comName = "AttributeUp_A", hideBelow = false}
, 
TalentEnergyUpAttrWindow = {name = "TalentEnergyUpAttrWindow", package = "Talent", comName = "AttributeUp_B", hideBelow = false}
, 
HandBookMainWindow = {name = "HandBookMainWindow", package = "HandBook", comName = "HandBookMain", hideBelow = true}
, 
HandBookStoryPlotWindow = {name = "HandBookStoryPlotWindow", package = "HandBook", comName = "StoryPlot", hideBelow = true}
, 
HandBookRelationListWindow = {name = "HandBookRelationListWindow", package = "HandBook", comName = "RelationList", hideBelow = false}
, 
HandBookCardGrowUpWindow = {name = "HandBookCardGrowUpWindow", package = "HandBook", comName = "CardGrowUp", hideBelow = false}
, 
HandBookRelationWindow = {name = "HandBookRelationWindow", package = "HandBook", comName = "Relation", hideBelow = true}
, 
HandBookCardPlotWindow = {name = "HandBookCardPlotWindow", package = "HandBook", comName = "CardPlot", hideBelow = true}
, 
HandBookAlbumWindow = {name = "HandBookAlbumWindow", package = "HandBook", comName = "Album", hideBelow = true}
, 
HandBookCGShowWindow = {name = "HandBookCGShowWindow", package = "CardPop", comName = "CardPlotCGShow", hideBelow = false}
, 
HandBookAlbumLetterWindow = {name = "HandBookAlbumLetterWindow", package = "HandBook", comName = "AlbumLetterWindow", hideBelow = false}
, 
HandBookIntimacyWindow = {name = "HandBookIntimacyWindow", package = "HandBook", comName = "Intimacy", hideBelow = true}
, 
AdventureGameWindow = {name = "AdventureGameWindow", package = "AdventureGame", comName = "AdventureGame", hideBelow = true}
, 
BuildingShowWindow = {name = "BuildingShowWindow", package = "AdventureGame", comName = "BuildingShowWindow", hideBelow = false}
, 
BuildingUseWindow = {name = "BuildingUseWindow", package = "AdventureGame", comName = "BuildingUseWindow", hideBelow = false}
, 
TenTimeResultWindow = {name = "TenTimeResultWindow", package = "AdventureGame", comName = "TenTimeResultWindow", hideBelow = false}
, 
TenTimeUIWindow = {name = "TenTimeUIWindow", package = "AdventureGame", comName = "TenTimeUIWindow", hideBelow = false}
, 
BuildingCardChoiceWindow = {name = "BuildingCardChoiceWindow", package = "AdventureGame", comName = "BuildingCardChoiceWindow", hideBelow = false}
, 
BuildingSureWindow = {name = "BuildingSureWindow", package = "AdventureGame", comName = "BuildingSureWindow", hideBelow = false}
, 
ControlChoiceWindow = {name = "ControlChoiceWindow", package = "AdventureGame", comName = "ControlChoiceWindow", hideBelow = false}
, 
BuffTipsWindow = {name = "BuffTipsWindow", package = "Expedition", comName = "BuffTipsWindow", hideBelow = false}
, 
HandBookCardPlotBattleWindow = {name = "HandBookCardPlotBattleWindow", package = "HandBook", comName = "CardPlotBattle", hideBelow = true}
, 
UnMakeEventWindow = {name = "UnMakeEventWindow", package = "AdventureGame", comName = "UnMakeEventWindow", hideBelow = false}
, 
VowRewardUpWindow = {name = "VowRewardUpWindow", package = "AdventureGame", comName = "VowRewardUpWindow", hideBelow = false}
, 
VowRewardChoiceWindow = {name = "VowRewardChoiceWindow", package = "AdventureGame", comName = "VowRewardChoiceWindow", hideBelow = false}
, 
HandBookEnterFightWindow = {name = "HandBookEnterFightWindow", package = "PlotDungeon", comName = "PlotDetailWindow", hideBelow = false, notReopen = true}
, 
TaroRewardChoiceWindow = {name = "TaroRewardChoiceWindow", package = "AdventureGame", comName = "TaroRewardChoice", hideBelow = false}
, 
HandBookInteractiveWindow = {name = "HandBookInteractiveWindow", package = "PlotPlay", comName = "PlotPlayPanel", hideBelow = true, notReopen = true}
, 
HandBookIntimacyUpWindow = {name = "HandBookIntimacyUpWindow", package = "HandBook", comName = "IntimacyUp", hideBelow = false, notReopen = true}
, 
BagSellAndBuyWindow = {name = "BagSellAndBuyWindow", package = "Bag", comName = "SellWindow", hideBelow = false}
, 
ActivityMainWindow = {name = "ActivityMainWindow", package = "Activity", comName = "ActivityMain", hideBelow = true}
, 
GuildNonpartyWindow = {name = "GuildNonpartyWindow", package = "Guild", comName = "ApplyRegister", hideBelow = true}
, 
GuildMainWindow = {name = "GuildMainWindow", package = "Guild", comName = "GuildMain", hideBelow = true}
, 
GuildRankingWindow = {name = "GuildRankingWindow", package = "Guild", comName = "GuildRanking", hideBelow = true}
, 
GuildWelfareWindow = {name = "GuildWelfareWindow", package = "Guild", comName = "Welfare", hideBelow = true}
, 
GuildGuessWindow = {name = "GuildGuessWindow", package = "Guild", comName = "Guess", hideBelow = true}
, 
GuildGuessRecordWindow = {name = "GuildGuessRecordWindow", package = "Guild", comName = "BuyResultWindow", hideBelow = false}
, 
GuildPlayerInfoWindow = {name = "GuildPlayerInfoWindow", package = "Guild", comName = "PlayerInfoWindow", hideBelow = false}
, 
GuildGuessOneKeyWindow = {name = "GuildGuessOneKeyWindow", package = "Guild", comName = "BuyNumberWindow", hideBelow = false, notReopen = true}
, 
GuildGuessResultWindow = {name = "GuildGuessResultWindow", package = "Guild", comName = "BuySpendWindow", hideBelow = false}
, 
GuildBuildingWindow = {name = "GuildBuildingWindow", package = "Guild", comName = "Build", hideBelow = true}
, 
GuildWelfareRankingWindow = {name = "GuildWelfareRankingWindow", package = "Guild", comName = "WelfareRanking", hideBelow = false}
, 
GuildRenameWindow = {name = "GuildRenameWindow", package = "Guild", comName = "RenameWindow", hideBelow = false}
, 
GuildDetailWindow = {name = "GuildDetailWindow", package = "Guild", comName = "GuildManage", hideBelow = true}
, 
GuildBadgeWindow = {name = "GuildBadgeWindow", package = "Guild", comName = "BadgeChoiceWindow", hideBelow = false}
, 
GuildDissolveWindow = {name = "GuildDissolveWindow", package = "Guild", comName = "DissolutionWindow", hideBelow = false, notReopen = true}
, 
NoticeWindow = {name = "NoticeWindow", package = "CommonResource", comName = "NoticeWindow", hideBelow = false}
, 
AdventureMiniRPSGameWindow = {name = "AdventureMiniRPSGameWindow", package = "AdventureGame", comName = "RPSMain", hideBelow = false}
, 
AdventureGame_Question = {name = "AdventureGame_Question", package = "AdventureGame", comName = "AnswerWindow", hideBelow = false}
, 
AdventureGame_BrickGame = {name = "AdventureGame_BrickGame", package = "AdventureGame", comName = "BrickGame", hideBelow = false}
, 
AdventureGame_GoldGame = {name = "AdventureGame_GoldGame", package = "AdventureGame", comName = "GoldGame", hideBelow = false}
, 
BattleWinConvergeWindow = {name = "BattleWinConvergeWindow", package = "Battle", comName = "BattleWin", hideBelow = false, notReopen = true}
, 
BattleFailConvergeWindow = {name = "BattleFailConvergeWindow", package = "Battle", comName = "BattleFail", hideBelow = false, notReopen = true}
, 
EquipmentFilterWindow = {name = "EquipmentFilterWindow", package = "Equipt", comName = "EquiptScreenWindow", hideBelow = false}
, 
ActivityCarnivalWindow = {name = "ActivityCarnivalWindow", package = "Carnival", comName = "CarnivalMain", hideBelow = true}
, 
SystemSetWindow = {name = "SystemSetWindow", package = "ActorInfo", comName = "SystemSetWindow", hideBelow = false, notReopen = true}
, 
MonsterDetailWindow = {name = "MonsterDetailWindow", package = "Tower", comName = "Monster", hideBelow = false}
, 
TowerChallengeWindow = {name = "TowerChallengeWindow", package = "Tower", comName = "RewardShowWindow", hideBelow = false}
, 
GuidePictureWindow = {name = "GuidePictureWindow", package = "Guide", comName = "PictureLook", hideBelow = false}
, 
ActivityDungeonWindow = {name = "ActivityDungeonWindow", package = "ActivityDungeon", comName = "ActivityDungeon", hideBelow = true}
, 
RenameWindow = {name = "RenameWindow", package = "ActorInfo", comName = "RenameWindow", hideBelow = false}
, 
NameWindow = {name = "NameWindow", package = "Message", comName = "NamingWindow", hideBelow = false, notReopen = true}
, 
PlayerLevelUpWindow = {name = "PlayerLevelUpWindow", package = "Message", comName = "LevelUp", hideBelow = false, notReopen = true}
, 
GuildLevelUpWindow = {name = "GuildLevelUpWindow", package = "Guild", comName = "GuildLevelUp", hideBelow = false, notReopen = true}
, 
CardDetailsWindow = {name = "CardDetailsWindow", package = "CardPop", comName = "CardDetails", hideBelow = false, notReopen = true}
, 
NewCardGetWindow = {name = "NewCardGetWindow", package = "CardPop", comName = "NewCardGet", hideBelow = false, notReopen = true}
, 
CardCommentWindow = {name = "CardCommentWindow", package = "Card", comName = "CardCommentWindow", hideBelow = false}
, 
CardLookWindow = {name = "CardLookWindow", package = "Card", comName = "CardLook", hideBelow = false, notReopen = true}
, 
TicketWindow = {name = "TicketWindow", package = "GetWay", comName = "TicketWindow", hideBelow = false}
, 
PlotChapterFinshWindow = {name = "PlotChapterFinshWindow", package = "PlotDungeon", comName = "PlotEnd", hideBelow = false, notReopen = true}
, 
PlotChapterBoxGetWindow = {name = "PlotChapterBoxGetWindow", package = "PlotDungeon", comName = "BoxGet", hideBelow = false}
, 
AnnouncementWindow = {name = "AnnouncementWindow", package = "Announcement", comName = "AnnouncementWindow", hideBelow = false}
, 
CGPreviewWindow = {name = "CGPreviewWindow", package = "CGcollection", comName = "CGLookWindow", hideBelow = false}
, 
CGShowWindow = {name = "CGShowWindow", package = "CGcollection", comName = "CG", hideBelow = false}
, 
GuideTipsWindow = {name = "GuideTipsWindow", package = "GuideTips", comName = "GuideTipsWindow", hideBelow = false}
, 
ArenaSettleRewardWindow = {name = "ArenaSettleRewardWindow", package = "Arena", comName = "Sum", hideBelow = false}
, 
ArenaSettleWindow = {name = "ArenaSettleWindow", package = "Arena", comName = "End", hideBelow = false}
, 
ArenaNewSeasonWindow = {name = "ArenaNewSeasonWindow", package = "Arena", comName = "Open", hideBelow = false}
, 
ExpeditionShopWindowWindow = {name = "ExpeditionShopWindowWindow", package = "Expedition", comName = "ExpeditionShopWindow", hideBelow = false}
, 
ShopMonthCardWindow = {name = "ShopMonthCardWindow", package = "Shop", comName = "MonthWindow", hideBelow = false}
, 
ActivityPassWordWindow = {name = "ActivityPassWordWindow", package = "Activity", comName = "TouristPassWordWindow", hideBelow = false}
, 
AssetBuyWindow = {name = "AssetBuyWindow", package = "Message", comName = "GoldBuyWindow", hideBelow = false}
, 
ShopGiftWindow = {name = "ShopGiftWindow", package = "Shop", comName = "GiftWindow", hideBelow = false}
, 
TowerBounsLevelWindow = {name = "TowerBounsLevelWindow", package = "Tower", comName = "EncounterWindow", hideBelow = false}
, 
SpendTipsWindow = {name = "SpendTipsWindow", package = "Message", comName = "SpendTipsWindow", hideBelow = false}
, 
ActivityDungeonMainWindow = {name = "ActivityDungeonMainWindow", package = "ActivityDungeon", comName = "ActivityMain", hideBelow = true}
, 
ActivityDungeonExchangeWindow = {name = "ActivityDungeonExchangeWindow", package = "ActivityDungeon", comName = "Exchange", hideBelow = true}
, 
HandBookPlotWindow = {name = "HandBookPlotWindow", package = "HandBook", comName = "AllPlot", hideBelow = true}
, 
HandBookActivityPlotWindow = {name = "HandBookActivityPlotWindow", package = "HandBook", comName = "ActivityPlotReview", hideBelow = true}
, 
BagGiftOptionWindow = {name = "BagGiftOptionWindow", package = "Gift", comName = "GiftChoiceWindow", hideBelow = false}
, 
BagBreakOptionWindow = {name = "BagBreakOptionWindow", package = "Gift", comName = "StageChoiceWindow", hideBelow = false}
, 
ShareMainWindow = {name = "ShareMainWindow", package = "Share", comName = "ShareMain", hideBelow = false}
, 
TitleWindow = {name = "TitleWindow", package = "Title", comName = "TitleWindow", hideBelow = true}
, 
FormationMonsterInfoWindow = {name = "FormationMonsterInfoWindow", package = "HandBook", comName = "MInformationWindow", hideBelow = false}
, 
AccountTipsWindow = {name = "AccountTipsWindow", package = "Activity", comName = "AccountTipsWindow", hideBelow = false}
}
_ENV.RegisterAllLuaWindowType = function(...)
  -- function num : 0_0 , upvalues : _ENV
  local uiMgr = UIMgr
  for i,v in pairs(WinResConfig) do
    if v.name then
      if v.notReopen then
        uiMgr:RegisterLuaWindowType(v.name, v.hideBelow, v.notReopen)
      else
        uiMgr:RegisterLuaWindowType(v.name, v.hideBelow, false)
      end
    end
  end
end

_ENV.WindowMsgEnum = {
HomeWindow = {E_MSG_UPDATE_ACTOR_INFO = 1, E_MSG_UPDATE_ACTIVITY_VISIBLE = 2, E_MSG_RESET_TASK_SPINE = 3, E_MSG_UPDATE_BG = 4}
, 
LoadingWindow = {E_MSG_UPDATE_LOADING_PROCESS = 1, E_MSG_UPDATE_LOADING_PROCESS_TWEEN = 2, E_MSG_UPDATE_LOADING_PROCESS_TWEEN_ADD = 3}
, 
MsgWaitingWindow = {E_MSG_UPDATE_TXT = 1}
, 
BattleUIWindow = {E_MSG_UPDATE_ROUND = 1, E_MSG_UPDATE_WAVE = 2, E_MSG_UPDATE_CARD_HP = 3, E_MSG_UPDATE_CARD_DANDER = 4, E_MSG_UPDATE_ORDER_LINE = 5, E_MSG_RESET_ORDER_LINE = 6, E_MSG_SHOW_DAMAGE = 7, E_MSG_SHOW_SKILL_INFO = 8, E_MSG_CHANGE_WAVE_UPDATE = 9, E_MSG_SHOW_WAVE_START = 10, E_MSG_SHOW_BOSS_COME = 11, E_MSG_HIDE_UNIQUE_UI = 12, E_MSG_SHOW_UNIQUE_UI = 13, E_MSG_UPDATE_SETTING_UI = 14, E_MSG_UPDATE_BOSS_BLOOD = 15, E_MSG_PLAY_SKILL_EFFECT = 16, E_MSG_REFRESH_ORDER_LINE = 17, E_MSG_REOPEN = 18, E_MSG_PLAY_SKILL_CARD = 19, E_MSG_BATTLE_PAUSE = 20, E_MSG_UPDATE_BOTTOM_HEAD = 21, E_MSG_UPDATE_CARD_SHIELD = 22}
, 
CardWindow = {E_MSG_CARD_INFO = 1, E_MSG_CARD_LEVELUP = 2, E_MSG_CARD_STAGEUP = 3, E_MSG_CARD_STAGEUPPROPERTY = 4, E_MSG_CARD_SKILLGET = 5, E_MSG_CARD_CARDGET = 6, E_MSG_CARD_SKILLUP = 7, E_MSG_CARD_SKILLDETAIL = 8, E_MSG_CARD_GOODCHANGE = 9, E_MSG_CARD_REFRESHCARDLISTBUTTOM = 10, E_MSG_CARD_SENDCARDDATATOINFO = 11, E_MSG_CARD_STARUP = 12, E_MSG_CARD_SETFASHIONID = 13, E_MSG_CARD_CLOSECARDCHOICE = 14, E_MSG_CARD_CHOICESELECTCARDLIST = 15, E_MSG_CARD_PIECE_EXCHANGE_COUNT = 16, E_MSG_CARD_AFTER_EXCHANGE = 17, E_MSG_CARD_STAR_UP_EFFECT = 18, E_MSG_CARD_PICE_TO_CARD = 19, E_MSG_CARD_USE_EXP_PROP = 20, E_MSG_CARD_CLOSECARDINFO = 21, E_MSG_CARD_CHOICEWINDOWSELECT = 22, E_MSG_CARD_LEVELUP_TRUE = 23, E_MSG_CARD_STAGEUP_TRUE = 24, E_MSG_CARD_STARUP_TRUE = 25, E_MSG_CARD_CLOSEGET_TOLIST = 26, E_MSG_CARD_LIST_SCROLL = 27, E_MSG_CARD_SWEEP_END = 28, E_MSG_GETWAY_CLOESED = 29, E_MSG_CARD_SETMAINFASHION = 30, E_MSG_CARD_CLOSECARDLOOK = 31}
, 
Lottery = {E_MSG_LOTTERY_INIT = 1, E_MSG_LOTTERY_DRAW = 2, E_MSG_LOTTERY_SHOWREWARD = 3, E_MSG_LOTTERY_REWARDCLOSE = 4, E_MSG_LOTTERY_DRAW_ANIMATION_END = 5, E_MSG_ONCLOSE_NEWGET = 6, E_MSG_ONCLICKCARDGET_SKIPBTN = 7, E_MSG_THE_ENDOFTHE_FRESH = 8, E_MSG_REFRESHLOTTERYLIST = 9}
, 
Equipt = {E_MSG_REFRESH_EQUIPMENT = 1, E_MSG_REFRESH_EQUIPMENT_IN_BAG = 2, E_MSG_REFRESH_LOCK_EQUIPMENT = 3, E_MSG_REFRESH_CHOSED_MAIN_ATTR = 4, E_MSG_DISABLE_ALL_DECOMPOSE = 5, E_MSG_REFRESH_EQUIPMENT_TO_IDENTIFY = 6, E_MSG_REFRESH_EQUIPMENT_TO_DECOMPOSE = 7, E_MSG_REFRESH_ALL_CHOOSE_BTN = 8, E_MSG_PLAY_IDENTIFY_EFFECT = 9}
, 
PlotPlay = {E_MSG_PLAY_CHAPTER_NAME = 1, E_MSG_PLAY_DIALOGUE = 2, E_MSG_SET_BACKGROUND = 3, E_MSG_FINISH = 4, E_MSG_BACKGROUND_ENTER = 5, E_MSG_SHOW_ASIDE = 6, E_MSG_CAMERA_SHAKE = 7, E_MSG_SET_BTN = 8, E_MSG_STOP_SOUND = 9, E_MSG_CALLBACK_KEEP = 10, E_MSG_RECYCLE_ROLE_RES = 11}
, 
Mail = {E_MSG_MAIL_LIST = 1, E_MSG_MAIL_DETAIL = 2, E_MSG_MAIL_DELETE = 3, E_MSG_MAIL_GET = 4}
, 
ActorInfo = {E_MSG_SETFASHIONHEAD = 1, E_MSG_SET_NEW_NICKNAME = 2}
, 
Talent = {E_MSG_TALENT_INIT = 1, E_MSG_TALENT_UP_NODE = 2, E_MSG_TALENT_UP_SEAL = 3, E_MSG_TALENT_STARUP_CLOSE = 4}
, 
Arena = {E_MSG_REFRESH_INFO = 1, E_MSG_REFRESH_RIVAL = 2, E_MSG_REFRESH_REWARD = 3, E_MSG_REFRESH_CHALLENGE_TIMES = 4, E_MSG_REFRESH_SELF_RANK = 5, E_MSG_REFRESH_CHALLENGE_CD = 6, E_MSG_SMASH = 7, E_MSG_CHALLENGE = 8, E_MSG_REFRESH_FC = 9}
, 
Tower = {E_MSG_REFRESH_BOUNS_STATUS = 1, E_MSG_REFRESH_SELF_FC = 2}
, 
Adventure = {E_MSG_CHANGE_STATUE = 1, E_MSG_ROLE_MOVE = 2, E_MSG_NODE_ANIM = 3, E_MSG_CHANGE_MAP = 4, E_MSG_REFRESH_BUILDING_STATUE = 5, E_MSG_REFRESH_UNDONE_EVENT = 6, E_MSG_REFRESH_WISH_POINT = 7, E_MSG_CHANGE_DRAG_STATUE = 8, E_MSG_SHOW_CHOOSE_FORK = 9, E_MSG_SHOW_TAROT_RESULT = 10, E_MSG_SHOW_DESTINATION_MARKER = 11, E_MSG_AFTER_SEND_SCREEN_BULLET = 12, E_MSG_SHOW_RPS_RESULT = 13, E_MSG_PLAY_DICE_ANIM = 14, E_MSG_FOCUS_ON_CHARACTER = 15, E_MSG_CLOSE_REWARDGET_WINDOW = 16, E_MSG_GOLD_REWARDS = 17, E_MSG_QUESTION_REWARDS = 18, E_MSG_BRICK_REWARDS = 19, E_MSG_FINISH_NODE_ANIM = 20, E_MSG_REFRESH = 21, E_MSG_REFRESH_CTRL_REDDOT = 22}
, 
MessageWindow = {E_MSG_REWARD_REFRESH = 1, E_Msg_INIT_CONFIRM = 2, E_Msg_CHANGE_CONFIRM_ARG = 3, E_Msg_SHOW_CONFIRM = 4, E_Msg_CLOSE_CONFIRM = 5, E_Msg_REFRESH_BUY_TIMES = 6, E_Msg_REFRESH_BUY_COSTS = 7, E_MSG_POP_UP_CONFIRM = 8}
, 
NETBrokenReconnect = {E_MSG_RECONNECT_Ok = 10000}
, 
ClearingWindow = {E_MSG_REWARD_REFRESH = 1}
, 
BagWindow = {E_MSG_BAG_REFRESH = 1}
, 
PlotPlayWindow = {E_MSG_ENEMY_REFRESH = 1, E_MSG_SET_LIST = 2, E_MSG_CHECK_RED_DOT = 3, E_MSG_PLAY_DIE = 4, E_MSG_NEXT_CHAPTER = 5, E_MSG_CHECK_PASS_PROCESS = 6}
, 
ShopWindow = {E_MSG_REFRESH = 1, E_MSG_REFRESH_ITEM = 2, E_MSG_SET_TYPE = 3}
, 
DailyDungeonDifficultyWindow = {E_MSG_UPDATE_CHALLENGE = 1}
, 
HeroDungeonMainWindow = {E_MSG_REFRESH = 1, E_MSG_PASS_CHAPTER = 4}
, 
TaskWindow = {TASK_REFRESH_WINDOW = 1, TASK_REFRESH_TASK_LIST = 2, TASK_REFRESH_TASK_LIVELINESS = 3, TASK_CLOSE_SCROLL = 4}
, 
GuideWindow = {GUIDE_FINISH = 1, GUIDE_CONTINUAL = 2, GUIDE_CHECK = 3, GUIDE_INFER = 4, GUIDE_SET_GUIDE_SHOW = 5, GUIDE_CURRENT_STEP_OVER = 6}
, 
ExpeditionEventWindow = {SINGLE_HEAL = 1, SINGLE_REGAIN = 2, ENTIRE_HEAL = 3, REFRESH_SHOP_LIST = 4}
, 
ExpeditionWindow = {GOTO_NEXT_POINT = 1, GOTO_BACK_POINT = 2, PLAY_BUFF_EFFECT = 3, CHANGE_SWEEP_TIMES = 4, SWEEP_SHOW = 5}
, 
HandBookIntimacyWindow = {SHOW_HEAD_LIST = 1, SHOW_CARD_INFORMATION = 2, SHOW_CARD_LEVEL_INFORMATION = 3, RELATION_ACTIVETION = 4, CLOSE_LIST_WINDOW = 5, REFRESH_INTIMACY_ITEM = 6, E_MSG_CARD_PICE_TO_CARD = 7}
, 
ActivityMainWindow = {SING_INIT = 1, VIT_GET_INIT = 2, BINDING = 3, GIFT_CODE = 4, SEVEN_DAY = 5, INFORM_CHILD_VIEW = 999}
, 
Guild = {E_MSG_JOIN_GUILD = 1, E_MSG_REFRESH_GUILD_LIST = 2, E_MSG_INIT_GUILD_CHAT = 3, E_MSG_REFRESH_MEMBER_RIGHTS = 4, E_MSG_REFRESH_MEMBER_LIST = 5, E_MSG_REFRESH_BUILD_INFO = 6, E_MSG_REFRESH_WELFARE_STATUS = 7, E_MSG_REFRESH_WELFARE_RANK = 8, E_MSG_REFRESH_GUILD_ICON = 9, E_MSG_REFRESH_GUILD_NAME = 10, E_MSG_REFRESH_GUILD_CONDITION = 11, E_MSG_REFRESH_GUILD_ANNOUNCEMENT = 12, E_MSG_REFRESH_GUILD_LOG = 13, E_MSG_REFRESH_GUILD_MEMBER = 14, E_MSG_REFRESH_GUILD_APPLY = 15, E_MSG_MY_APPLY_APPROVED = 16, E_MSG_KICK_OUT_GUILD = 17, E_MSG_REFRESH_GUILD_NAME = 18}
, 
AssetShop = {E_MSG_DIAMOND = 1, E_MSG_GOLD = 2, E_MSG_PHYSICAL = 3}
, 
ActivityCarnival = {E_MSG_CHANGE_GROUP = 1, E_MSG_GET_TASK = 2, E_MSG_GET_INTEGER = 3, E_MSG_GET_COUNTDOWN = 4}
, 
ActivityDungeon = {E_MSG_REFRESH = 1, E_MSG_SET_COUNTDOWN = 2, E_MSG_REFRESH_RED = 3}
, 
ActivityMainDungeon = {E_MSG_SET_TIME = 1}
, 
Announcement = {E_MSG_REFRESH = 1, E_MSG_REFRESH_TITLE = 2}
, 
GuideTips = {E_MSG_SHOW_TIPS = 1}
, 
ActivityDungeonExchange = {E_MSG_SHOW_RESULT = 1, E_MSG_RESET = 2, E_MSG_REFRESH = 3}
, 
Title = {E_MSG_REFRESH = 1, E_MSG_RED_DOT = 2}
}
_ENV.WindowLoadPackages = {
LoginWindow = {"LandPic"}
, 
HomeWindow = {"HomeAd", "CardHeadIconCircle", "HomeBg"}
, 
ActorInfoWindow = {"CardHeadIconCircle", "Title"}
, 
BattleUIWindow = {"MonsterHeadCircle", "BattleArtNumber", "BattleCharacterHead", "BattleCorizontalCardIcon", "CardHeadIconCircle", "BuffIcon"}
, 
BattleDataWindow = {"MonsterHeadSquare"}
, 
CardListWindow = {"CharacterHeadBanner"}
, 
LotteryWindow = {"GachaCharacter001"}
, 
ShopWindow = {"Equipicon", "Equipt"}
, 
BagWindow = {"Equipicon", "Equipt"}
, 
GetWayWindow = {"Equipicon"}
, 
MailWindow = {"Equipicon"}
, 
TowerWindow = {"Equipicon", "PlotUIBackGround"}
, 
EquipmentWindow = {"Equipicon"}
, 
HandBookCardPlotWindow = {"CharacterHeadBanner"}
, 
ExpeditionDetailWindow = {"PlotUIBackGround"}
, 
ExpeditionWindow = {"BuffIcon"}
, 
PlotDetailWindow = {"PlotUIBackGround"}
, 
ClearingWindow = {"PlotUIBackGround"}
, 
HandBookEnterFightWindow = {"PlotUIBackGround"}
, 
GuildMainWindow = {"CardHeadIconCircle"}
, 
GuildWelfareRankingWindow = {"CardHeadIconCircle"}
, 
GuildDetailWindow = {"CardHeadIconCircle", "Title"}
, 
SkillTipsWindow = {"Talent", "SkillIcon"}
, 
SkillGetGrpWindow = {"SkillIcon"}
, 
CardGetShowWindow = {"SkillIcon"}
, 
CardWindow = {"SkillIcon"}
, 
FormationWindow = {"SkillIcon", "BuffIcon", "Equipicon", "MonsterHeadSquare"}
, 
BattleWinConvergeWindow = {"Equipicon", "Land"}
, 
HandBookCardPlotBattleWindow = {"Land"}
, 
TowerChallengeWindow = {"SkillIcon", "BuffIcon", "Equipicon"}
, 
CardDetailsWindow = {"SkillIcon"}
, 
ArenaWindow = {"BattleCharacterHead"}
, 
CardCommentWindow = {"CharacterHeadBanner"}
, 
CardChoiceWindow = {"CharacterHeadBanner"}
, 
AdventureGameWindow = {"BattleCharacterHead"}
, 
HandBookCardGrowUpWindow = {"CharacterHeadBanner"}
, 
MonsterDetailWindow = {"HandBook", "BattleArtNumber"}
, 
DailyDungeonPassRewardWindow = {"CharacterHeadBanner"}
, 
ArenaRankWindow = {"CardHeadIconCircle", "CharacterHeadBanner", "Title"}
, 
ArenaRecordWindow = {"CardHeadIconCircle"}
, 
PlotPlayPanelWindow = {"PlotChapterRes"}
, 
PlotPlayWindow = {"PlotChapterRes"}
, 
HeroDungeonMainWindow = {"PlotChapterRes"}
, 
HandBookStoryPlotWindow = {"HandBookBanner"}
, 
HandBookCardPlotBattleWindow = {"CardHeadIconCircle", "MonsterHeadCircle"}
, 
CGPreviewWindow = {"HandBookCGBanner"}
, 
HandBookAlbumWindow = {"HandBookCGBanner"}
, 
HandBookActivityPlotWindow = {"HandBookCGBanner"}
, 
BagGiftOptionWindow = {"Equipicon"}
, 
StoryReviewWindow = {"MonsterHeadSquare"}
, 
CardGetShowWindow = {"Share"}
, 
LotteryRewardWindow = {"Share"}
, 
NewCardGetWindow = {"Share"}
, 
PiceGetShowWindow = {"Share"}
, 
HandBookCGShowWindow = {"Share"}
}

