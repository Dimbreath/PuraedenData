-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_ActivityDungeonByName")
local ActivityDungeonWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local currentChapter = 0
local ChapterIds = {}
local mTime = nil
local stages = {}
local centerIndex = 0
local midX = nil
local isInit = true
local UntilPos = "ActivityUntilPos"
local chapterRe = 0
local isRe = false
local timer = 0
ActivityDungeonWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, timer, uis, ActivityDungeonWindow, isInit, ChapterIds, currentChapter
  bridgeObj:SetView((WinResConfig.ActivityDungeonWindow).package, (WinResConfig.ActivityDungeonWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  timer = 0
  uis = GetActivityDungeon_ActivityDungeonUis(contentPane)
  ;
  (ActivityDungeonWindow.InitAssetStrip)()
  ;
  (ActivityDungeonWindow.InitMapList)()
  isInit = true
  local argID = tonumber((PlotDungeonMgr.ActivityDungeonRecodeID)())
  local ActivityData = ((TableData.gTable).BaseActivityChapterData)[argID]
  ChapterIds = {Simple = ActivityData.normal_chapter, Difficult = ActivityData.hard_chapter}
  ;
  (ActivityDungeonWindow.InitBtnEvent)()
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

  if currentChapter > 0 then
    if currentChapter == ChapterIds.Simple then
      (uis.c1Ctr).selectedIndex = 0
      ;
      ((uis.Difficulty_01_Btn).onClick):Call()
    else
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.c1Ctr).selectedIndex = 1
      ;
      ((uis.Difficulty_02_Btn).onClick):Call()
    end
  else
    local hard = (PlotDungeonMgr.ChapterIsOpen)(ChapterIds.Difficult)
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R4 in 'UnsetPending'

    if hard then
      (uis.c1Ctr).selectedIndex = 1
      ;
      ((uis.Difficulty_02_Btn).onClick):Call()
    else
      -- DECOMPILER ERROR at PC76: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (uis.c1Ctr).selectedIndex = 0
      ;
      ((uis.Difficulty_01_Btn).onClick):Call()
    end
  end
  do
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.MapList).scrollPane).bouncebackEffect = false
  end
end

ActivityDungeonWindow.InitMapList = function(...)
  -- function num : 0_1 , upvalues : uis, ActivityDungeonWindow
  local list = uis.MapList
  list.itemRenderer = ActivityDungeonWindow.ListRenderer
  list:SetVirtual()
  ;
  ((list.scrollPane).onScroll):Add(ActivityDungeonWindow.OnListScroll)
end

ActivityDungeonWindow.ListRenderer = function(index, obj, ...)
  -- function num : 0_2 , upvalues : _ENV, stages, centerIndex, ActivityDungeonWindow, uis, isInit, UntilPos, currentChapter, isRe
  local stageId = tonumber(stages[index + 1])
  if stageId == nil or stageId == -1 then
    obj.visible = false
    return 
  end
  local stageData = ((TableData.gTable).BaseStageData)[stageId]
  if stageData == nil then
    return 
  end
  obj.visible = true
  ;
  (obj:GetChild("IconLoader")).url = (Util.GetItemUrl)(stageData.icon)
  ;
  (obj:GetChild("NameLoader")).url = (Util.GetItemUrl)(stageData.name_icon)
  if (PlotDungeonMgr.IsFirstChallengeStage)(stageId) then
    ChangeUIController(obj, "c1", 1)
  else
    if (PlotDungeonMgr.IsCanChallenge)(stageId, false) then
      ChangeUIController(obj, "c1", 0)
    else
      ChangeUIController(obj, "c1", 2)
    end
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : index, centerIndex, ActivityDungeonWindow, _ENV, stageId, uis
    if index == centerIndex then
      if (ActivityDungeonWindow.PlotActivityIsOpen)() then
        (PlotDungeonMgr.OnClickStage)(stageId, false)
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000520))
      end
    else
      ;
      (uis.MapList):ScrollToView(index - 2, true)
    end
  end
)
  local debris = stageData.card_show
  local debrisBg = obj:GetChild("n14")
  local debrisLoader = obj:GetChild("RewardLoader")
  if debris and debris ~= "0" then
    debrisBg.visible = true
    debrisLoader.visible = true
    debrisLoader.url = (Util.GetItemUrl)(debris)
  else
    debrisBg.visible = false
    debrisLoader.visible = false
  end
  local mIndex = (ActivityDungeonWindow.GetChallengeIndex)()
  if index == 2 and isInit then
    local RIndex = tonumber((Util.GetPlayerSetting)(UntilPos .. currentChapter, -1))
    if mIndex == 0 or isRe and RIndex == 2 then
      local ss = 1.3
      obj.scale = Vector2(ss, ss)
      obj.width = 236 * ss
      centerIndex = index
      isInit = false
    end
  end
end

ActivityDungeonWindow.PlotActivityIsOpen = function(...)
  -- function num : 0_3 , upvalues : _ENV
  local time = (((ActivityMgr.InitActivityDungeonData)()).baseActivityInfo).endTime
  do return time - (ActorData.GetServerTime)() > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityDungeonWindow.SetCountDown = function(time, ...)
  -- function num : 0_4 , upvalues : mTime, uis, _ENV
  if mTime then
    mTime:Stop()
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.Time_01_Txt).text = (PUtil.get)(20000220)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  if time - (ActorData.GetServerTime)() <= 0 then
    (uis.Time_02_Txt).text = (PUtil.get)(20000221)
  else
    mTime = (LuaTime.CountDown)(time * 0.001 - (ActorData.GetServerTime)() * 0.001, uis.Time_02_Txt, function(...)
    -- function num : 0_4_0 , upvalues : uis, _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    (uis.Time_02_Txt).text = (PUtil.get)(20000221)
  end
, true)
  end
end

ActivityDungeonWindow.OnListScroll = function(...)
  -- function num : 0_5 , upvalues : uis, midX, _ENV, centerIndex, timer
  if uis == nil then
    return 
  end
  midX = -((((uis.MapList).container).cachedTransform).localPosition).x + (uis.MapList).viewWidth / 2
  ;
  (uis.MapList):TraversalItem(function(index, obj, ...)
    -- function num : 0_5_0 , upvalues : _ENV, midX, centerIndex
    local dist = (math.abs)(midX - obj.x - obj.width / 2)
    if obj.width < dist then
      obj.scale = Vector2.one
      obj.width = 236
    else
      local ss = 1 + (math.abs)(1 - dist / obj.width) * 0.3
      obj.scale = Vector2(ss, ss)
      obj.width = 236 * ss
      if ss > 1.2 then
        centerIndex = index
      end
    end
  end
)
  timer = timer + 1
  if timer % 2 == 0 then
    (uis.MapList):RefreshVirtualList()
  end
end

ActivityDungeonWindow.InitBtnEvent = function(...)
  -- function num : 0_6 , upvalues : uis, _ENV, UntilPos, currentChapter, centerIndex, ChapterIds, ActivityDungeonWindow, chapterRe
  ((uis.Difficulty_01_Btn):GetChild("NameTxt")).text = (PUtil.get)(20000217)
  ;
  ((uis.Difficulty_01_Btn).onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : _ENV, UntilPos, currentChapter, centerIndex, ChapterIds, ActivityDungeonWindow, chapterRe
    (Util.SetPlayerSetting)(UntilPos .. currentChapter, centerIndex)
    currentChapter = ChapterIds.Simple
    ;
    (ActivityDungeonWindow.RefreshChapter)()
    ;
    (PlotDungeonMgr.SetSelectChapter)(currentChapter)
    chapterRe = currentChapter
  end
)
  ;
  ((uis.Difficulty_02_Btn):GetChild("NameTxt")).text = (PUtil.get)(20000218)
  ;
  ((uis.Difficulty_02_Btn).onClick):Set(function(...)
    -- function num : 0_6_1 , upvalues : _ENV, ChapterIds, UntilPos, currentChapter, centerIndex, ActivityDungeonWindow, chapterRe, uis
    if (PlotDungeonMgr.ChapterIsOpen)(ChapterIds.Difficult) then
      (Util.SetPlayerSetting)(UntilPos .. currentChapter, centerIndex)
      currentChapter = ChapterIds.Difficult
      ;
      (ActivityDungeonWindow.RefreshChapter)()
      ;
      (PlotDungeonMgr.SetSelectChapter)(currentChapter)
      chapterRe = currentChapter
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000383))
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.c1Ctr).selectedIndex = 0
    end
  end
)
  ;
  ((uis.ExchangeBtn).onClick):Set(function(...)
    -- function num : 0_6_2 , upvalues : _ENV
    ld("Slots")
    ;
    (SlotsService.ReqSlotsData)((SlotsData.SlotType).ACTIVITY_SLOT)
  end
)
  ;
  ((uis.PlotBtn).onClick):Set(function(...)
    -- function num : 0_6_3 , upvalues : _ENV
    local acID = (ActivityMgr.GetOpenActivityByType)((ActivityMgr.ActivityType).ActivityDungeon)
    local ActivityData = ((TableData.gTable).BaseActivityData)[acID]
    ;
    (HandBookService.OnReqAdventureStoryChapter)((ProtoEnum.E_BATTLE_TYPE).ACTIVITY, ActivityData.story_type)
  end
)
  if not (PlotDungeonMgr.ChapterIsOpen)(ChapterIds.Difficult) then
    ((uis.Difficulty_02_Btn).onClick):AddCapture(function(eventContext, ...)
    -- function num : 0_6_4 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(20000383))
    eventContext:StopPropagation()
  end
)
    ChangeUIController(uis.Difficulty_02_Btn, "lock", 1)
  else
    ChangeUIController(uis.Difficulty_02_Btn, "lock", 0)
  end
  ;
  (ActivityDungeonWindow.SetRedDot)()
  ;
  (GuideData.RegisterGuideAndControl)(ControlID.HandBook_Album, uis.PlotBtn, (WinResConfig.ActivityDungeonWindow).name)
end

ActivityDungeonWindow.SetRedDot = function(...)
  -- function num : 0_7 , upvalues : uis, _ENV
  ((uis.ExchangeBtn):GetChild("RedDot")).visible = (ActorData.GetAssetCount)(AssetType.ACTIVITY_SCORE) > 0
  ;
  ((uis.PlotBtn):GetChild("RedDot")).visible = (ActivityMgr.PlotRedDotShow)()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityDungeonWindow.RefreshChapter = function(...)
  -- function num : 0_8 , upvalues : _ENV, currentChapter, uis, stages, isRe, ActivityDungeonWindow, UntilPos
  local chapterData = ((TableData.gTable).BaseChapterData)[tonumber(currentChapter)]
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.NameTxt).text = chapterData.name
  stages = split(chapterData.stages, ":")
  local lastStage = tonumber(stages[#stages])
  ;
  (table.insert)(stages, 1, -1)
  ;
  (table.insert)(stages, 1, -1)
  ;
  (table.insert)(stages, -1)
  ;
  (table.insert)(stages, -1)
  isRe = false
  local sIndex = (ActivityDungeonWindow.GetChallengeIndex)()
  do
    if (PlotDungeonMgr.IsPassDungeon)(lastStage) then
      local index = tonumber((Util.GetPlayerSetting)(UntilPos .. currentChapter, -1))
      if index >= 0 then
        isRe = true
        sIndex = index - 2
      end
    end
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.MapList).numItems = #stages
    ;
    (SimpleTimer.setTimeout)(0.01, function(...)
    -- function num : 0_8_0 , upvalues : uis, sIndex
    if uis then
      (uis.MapList):ScrollToView(sIndex, true)
    end
  end
)
  end
end

ActivityDungeonWindow.GetChallengeIndex = function(...)
  -- function num : 0_9 , upvalues : _ENV, stages
  for i,v in ipairs(stages) do
    local stageId = tonumber(v)
    if stageId ~= -1 and (PlotDungeonMgr.IsFirstChallengeStage)(stageId) then
      return i - 3
    end
  end
  return #stages - 3
end

ActivityDungeonWindow.OnShown = function(...)
  -- function num : 0_10 , upvalues : _ENV, ActivityDungeonWindow
  local time = (((ActivityMgr.InitActivityDungeonData)()).baseActivityInfo).endTime
  ;
  (ActivityDungeonWindow.SetCountDown)(time)
end

ActivityDungeonWindow.OnHide = function(...)
  -- function num : 0_11
end

ActivityDungeonWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : mTime, uis, contentPane, argTable, _ENV, UntilPos, chapterRe, centerIndex
  if mTime then
    mTime:Stop()
  end
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ActivityDungeonWindow).name)
  ;
  (Util.SetPlayerSetting)(UntilPos .. chapterRe, centerIndex)
end

ActivityDungeonWindow.InitAssetStrip = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis, currentChapter
  local m = {}
  m.windowName = (WinResConfig.ActivityDungeonWindow).name
  m.Tip = (PUtil.get)(20000216)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  m.CloseBtnFun = function(...)
    -- function num : 0_13_0 , upvalues : currentChapter
    currentChapter = 0
  end

  m.BackBtnFun = function(...)
    -- function num : 0_13_1 , upvalues : currentChapter
    currentChapter = 0
  end

  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ActivityDungeonWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14 , upvalues : _ENV, ActivityDungeonWindow
  if msgId == (WindowMsgEnum.ActivityDungeon).E_MSG_REFRESH then
    (ActivityDungeonWindow.RefreshChapter)()
  else
  end
  if msgId ~= (WindowMsgEnum.ActivityDungeon).E_MSG_SET_COUNTDOWN or msgId == (WindowMsgEnum.ActivityDungeon).E_MSG_REFRESH_RED then
    (ActivityDungeonWindow.SetRedDot)()
  end
end

return ActivityDungeonWindow

