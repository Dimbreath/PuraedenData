-- params : ...
-- function num : 0 , upvalues : _ENV
GuideData = {}
ControlID = {Name_SureBtn = 100001, Home_CharacterBtn = 100101, Home_TeamBtn = 100102, Home_EquipBtn = 100103, Home_AdventureBtn = 100104, Home_HandbookBtn = 100105, Home_ShopBtn = 100106, Home_UnionBtn = 100107, Home_LotteryBtn = 100108, Home_TaskBtn = 100109, Home_MailBtn = 100110, Home_BagBtn = 100111, Home_AssetShopBtn = 100112, Home_CarnivalBtn = 100113, LevelUp_SureBtn = 100201, CardList_List = 200101, CardList_List2 = 200102, Fight_SpeedUp = 101001, Fight_AutoFight = 101002, Fight_Head_1 = 101003, Fight_Stop = 101004, Fight_Setting = 101005, FightSettle_Next = 101101, FightSettle_BackStage = 101102, Shop_Grocer = 102001, Shop_Mystery = 102002, Shop_Token = 102003, Shop_Expedition = 102004, Shop_Recharge = 102005, Shop_Gift = 102006, Lottery_Part = 103001, Lottery_Equip = 103002, Lottery_Card = 103003, Lottery_NoviceSingle = 103011, Lottery_NoviceTen = 103012, Lottery_Back = 103013, GetCard_SureBtn = 103101, Task_Daily = 104001, Task_Week = 104002, Task_GrowUp = 104003, Task_List = 104011, Formation_Operation = 105001, Formation_Challenge = 105002, Formation_OneKey = 105003, Card_Strength = 200201, Card_Break = 200202, Card_Wake = 200203, Card_Talent = 200204, Card_Detail = 200205, Card_ExpMedical = 200211, Card_Close = 200212, Card_Comment = 200301, Card_BreakBtn = 200213, Card_WakeBtn = 200214, Card_TalentList = 200215, Break_Sure = 200401, Wake_Sure = 200501, Talent_Sure = 200601, Card_GetShow = 200701, Equipment_Detail = 210101, Equipment_Equip = 210102, Equipment_Identify = 210103, Equipment_ClearUp = 210104, Equipment_IdentifyBag = 210111, Equipment_IdentifyBtn = 210112, Equipment_Weapon = 210221, Equipment_AllBag = 210113, Equipment_TipsWear = 210114, Talent_Uplevel = 220101, Talent_Upstart = 220102, Talent_StarEnergy = 220103, HandBook_AdventureRecode = 230101, HandBook_Story = 230102, HandBook_Album = 230103, HandBook_Intimacy = 230104, HandBook_Relation = 230105, IntimacyList_List = 230601, Adventure_Plot = 300101, Adventure_Hero = 300102, Adventure_Daily = 300103, Adventure_Arena = 300104, Adventure_Tower = 300105, Adventure_Expedition = 300106, Adventure_Rich = 300107, Adventure_Back = 300108, PlotDungeon_Stage = 301000, PlotDungeon_OneOne = 301001, PlotDungeon_OneTwo = 301002, PlotDungeon_OneThree = 301003, PlotDungeon_OneFour = 301004, PlotDungeon_OneFive = 301005, PlotDungeon_TwoOne = 301006, PlotDungeon_TwoTwo = 301007, PlotDungeon_TwoThree = 301008, PlotDungeon_TwoFour = 301009, PlotDungeon_TwoFive = 301010, PlotDungeon_OneBox = 301021, PlotDungeon_TwoBox = 301022, PlotDungeon_Close = 301030, RewardGet_GetBtn = 301031, StageDetail_Panel = 301100, StageDetail_ChallengeBtn = 301101, StageDetail_SweepOneBtn = 301102, StageDetail_SweepTenBtn = 301103, Clear_SweepFiftyBtn = 301104, HeroChapterList_FirstChapter = 302001, HeroChapterSage_OneOne = 302101, Daily_Gold = 303001, Daily_Medical = 303002, Daily_Crystal = 303003, Daily_Sweep = 303011, Daily_GoldOne = 303012, Daily_MedicalOne = 303013, Arena_Opponent = 304001, Arena_Challenge = 304002, Arena_Reward = 304003, Arena_Career_Reward = 304004, Tower_OneChapter = 305001, Tower_OneOne = 305002, TowerDetail_Challenge = 305101, TowerDetail_Smash = 305102, Expedition_MapChoose = 306001, ExpeditionSure_SureBtn = 306201, BigAdventure_PlayOne = 307001, BigAdventure_Wish = 307002, Guild_Guess = 400101, Guild_Construction = 400102, Guild_Gift = 400103, Activity_Sign = 500101, Activity_Cake = 500102, Activity_SevenDay = 500103, AssetShop_Diamond = 107001, AssetShop_Gold = 107002, AssetShop_Physical = 107003, AssetShop_ENDURANCE = 107004, AssetShop_SPIRIT = 107005, GetWay_GetWay = 107101, Share = 600101, Setting_Title = 600201}
_ENV.BtnCorrespondMsgID = {[ControlID.Card_BreakBtn] = ((_ENV.Proto).MsgIdByName).ResQualityUp, [ControlID.Home_LotteryBtn] = ((_ENV.Proto).MsgIdByName).ResLotteryInit, [ControlID.Lottery_NoviceSingle] = ((_ENV.Proto).MsgIdByName).ResLotteryDraw, [ControlID.Card_ExpMedical] = ((_ENV.Proto).MsgIdByName).ResLevelUp, [ControlID.Home_TaskBtn] = ((_ENV.Proto).MsgIdByName).ResTaskData, [ControlID.Task_List] = ((_ENV.Proto).MsgIdByName).ResSubmitTask, [ControlID.Card_WakeBtn] = ((_ENV.Proto).MsgIdByName).ResStarUp, [ControlID.Adventure_Hero] = ((_ENV.Proto).MsgIdByName).ResStoryInit, [ControlID.Formation_Challenge] = ((_ENV.Proto).MsgIdByName).ResInStage, [ControlID.Home_ShopBtn] = ((_ENV.Proto).MsgIdByName).ResShopData, [ControlID.Adventure_Rich] = ((_ENV.Proto).MsgIdByName).ResAdventureInit, [ControlID.Adventure_Arena] = ((_ENV.Proto).MsgIdByName).ResArenaData, [ControlID.Home_UnionBtn] = ((_ENV.Proto).MsgIdByName).ResGuildList, [ControlID.Adventure_Daily] = ((_ENV.Proto).MsgIdByName).ResTrialInit, [ControlID.Adventure_Plot] = ((_ENV.Proto).MsgIdByName).ResStoryInit, [ControlID.Adventure_Expedition] = ((_ENV.Proto).MsgIdByName).ResExpedition, [ControlID.Adventure_Tower] = ((_ENV.Proto).MsgIdByName).ResTowerInit}
-- DECOMPILER ERROR at PC332: Confused about usage of register: R0 in 'UnsetPending'

GuideData.GuideStop = {Continual = 0, Stop = 1}
-- DECOMPILER ERROR at PC342: Confused about usage of register: R0 in 'UnsetPending'

GuideData.GuideType = {Basic = 1, Picture = 2}
local Self = GuideData
local GuideControl = {}
local ControlOfWin = {}
-- DECOMPILER ERROR at PC349: Confused about usage of register: R3 in 'UnsetPending'

GuideData.RegisterGuideAndControl = function(id, con, winName, ...)
  -- function num : 0_0 , upvalues : _ENV, GuideControl, ControlOfWin
  if not con then
    loge("注册id.." .. id .. "的控件为空")
    return 
  end
  if not (GuideData.IsContainCtr)(id, con) then
    local cons = GuideControl[id]
    if not cons then
      cons = {}
    end
    ;
    (table.insert)(cons, con)
    GuideControl[id] = cons
    local winId = ControlOfWin[winName]
    if not winId then
      winId = {}
    end
    ;
    (table.insert)(winId, id)
    ControlOfWin[winName] = winId
    ;
    (FunctionControlMgr.SetControlState)(id, con)
  end
end

-- DECOMPILER ERROR at PC354: Confused about usage of register: R3 in 'UnsetPending'

;
(_ENV.GuideData).AbolishControlRefer = function(winName, ...)
  -- function num : 0_1 , upvalues : ControlOfWin, _ENV, GuideControl
  local idS = ControlOfWin[winName]
  if not idS then
    return 
  end
  for _,v in ipairs(idS) do
    GuideControl[v] = nil
  end
  ControlOfWin[winName] = nil
end

-- DECOMPILER ERROR at PC359: Confused about usage of register: R3 in 'UnsetPending'

;
(_ENV.GuideData).IsContainCtr = function(id, con, ...)
  -- function num : 0_2 , upvalues : GuideControl, _ENV
  local cons = GuideControl[id]
  if cons then
    for _,v in pairs(cons) do
      if v == con then
        return true
      end
    end
  end
  do
    return false
  end
end

-- DECOMPILER ERROR at PC364: Confused about usage of register: R3 in 'UnsetPending'

;
(_ENV.GuideData).GetGuideControl = function(id, ...)
  -- function num : 0_3 , upvalues : _ENV, GuideControl
  if id and tonumber(id) > 0 then
    return GuideControl[tonumber(id)]
  end
end

-- DECOMPILER ERROR at PC369: Confused about usage of register: R3 in 'UnsetPending'

;
(_ENV.GuideData).GetGuideIdByControl = function(ctr, ...)
  -- function num : 0_4 , upvalues : _ENV, GuideControl
  for i,v in pairs(GuideControl) do
    for _,v2 in pairs(v) do
      if v2 == ctr then
        return i
      end
    end
  end
end


