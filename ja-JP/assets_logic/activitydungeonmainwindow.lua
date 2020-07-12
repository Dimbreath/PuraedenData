-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_ActivityMainByName")
local ActivityDungeonMainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local mListData = {}
ActivityDungeonMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ActivityDungeonMainWindow
  bridgeObj:SetView((WinResConfig.ActivityDungeonMainWindow).package, (WinResConfig.ActivityDungeonMainWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivityDungeon_ActivityMainUis(contentPane)
  ;
  (ActivityService.OnReqActivityInfo)((ActivityMgr.ActivityType).ActivityDungeon)
  ;
  (ActivityDungeonMainWindow.InitAssetStrip)()
  ;
  (ActivityDungeonMainWindow.InitInvariable)()
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ChapterList).itemRenderer = ActivityDungeonMainWindow.ItemRenderer
  ;
  (uis.ChapterList):SetVirtual()
  ;
  (ActivityDungeonMainWindow.RefreshList)()
  ;
  (((uis.ChapterList).scrollPane).onScroll):Set(function(...)
    -- function num : 0_0_0 , upvalues : ActivityDungeonMainWindow
    (ActivityDungeonMainWindow.SetArrowShow)()
  end
)
end

ActivityDungeonMainWindow.RefreshList = function(...)
  -- function num : 0_1 , upvalues : _ENV, mListData, uis, ActivityDungeonMainWindow
  local ActivityData = (TableData.gTable).BaseActivityChapterData
  mListData = {}
  for _,v in pairs(ActivityData) do
    (table.insert)(mListData, v)
  end
  ;
  (table.sort)(mListData, function(a, b, ...)
    -- function num : 0_1_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ChapterList).numItems = #mListData
  local index = (ActivityDungeonMainWindow.GetOpenIndex)()
  ;
  (uis.ChapterList):ScrollToView(index - 1)
end

ActivityDungeonMainWindow.GetOpenIndex = function(...)
  -- function num : 0_2 , upvalues : _ENV, mListData
  local index = 0
  for i,v in ipairs(mListData) do
    local normal = (PlotDungeonMgr.ChapterIsOpen)(v.normal_chapter)
    local hard = (PlotDungeonMgr.ChapterIsOpen)(v.hard_chapter)
    if (normal or hard) and index < i then
      index = i
    end
  end
  return index
end

ActivityDungeonMainWindow.ItemRenderer = function(index, obj, ...)
  -- function num : 0_3 , upvalues : mListData, _ENV
  local data = mListData[index + 1]
  if data == nil then
    return 
  end
  ;
  (obj:GetChild("PicLoader")).url = (Util.GetItemUrl)(data.icon)
  local normal = (PlotDungeonMgr.ChapterIsOpen)(data.normal_chapter)
  local hard = (PlotDungeonMgr.ChapterIsOpen)(data.hard_chapter)
  local unlock = normal or hard
  if unlock then
    ChangeUIController(obj, "c1", 0)
  else
    ChangeUIController(obj, "c1", 1)
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : unlock, _ENV, data
    if unlock then
      (PlotDungeonMgr.ActivityDungeonRecodeID)(data.id)
      OpenWindow((WinResConfig.ActivityDungeonWindow).name, UILayer.HUD)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000389))
    end
  end
)
end

ActivityDungeonMainWindow.InitInvariable = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis
  local acID = (ActivityMgr.GetOpenActivityByType)((ActivityMgr.ActivityType).ActivityDungeon)
  local ActivityData = ((TableData.gTable).BaseActivityData)[acID]
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.WordTxt).text = ActivityData.remark
  ;
  ((uis.PlotBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV, ActivityData
    (HandBookService.OnReqAdventureStoryChapter)((ProtoEnum.E_BATTLE_TYPE).ACTIVITY, ActivityData.story_type)
  end
)
  ;
  ((uis.ExchangeBtn).onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : _ENV
    ld("Slots")
    ;
    (SlotsService.ReqSlotsData)((SlotsData.SlotType).ACTIVITY_SLOT)
  end
)
  ;
  ((uis.LeftBtn).onClick):Set(function(...)
    -- function num : 0_4_2 , upvalues : uis
    ((uis.ChapterList).scrollPane):ScrollLeft(1.1, true)
  end
)
  ;
  ((uis.RightBtn).onClick):Set(function(...)
    -- function num : 0_4_3 , upvalues : uis
    ((uis.ChapterList).scrollPane):ScrollRight(1.1, true)
  end
)
  ;
  (Util.CreateShowModel)(ActivityData.fashion_id, uis.CardLoader)
  ;
  (((uis.root):GetChild("CardInfoBtn")).onClick):Set(function(...)
    -- function num : 0_4_4 , upvalues : _ENV, ActivityData
    local FashionData = ((TableData.gTable).BaseFashionData)[ActivityData.fashion_id]
    OpenWindow((WinResConfig.CardDetailsWindow).name, UILayer.HUD, FashionData.card_id)
  end
)
  ;
  ((uis.ExchangeBtn):GetChild("RedDot")).visible = (ActorData.GetAssetCount)(AssetType.ACTIVITY_SCORE) > 0
  ;
  ((uis.PlotBtn):GetChild("RedDot")).visible = (ActivityMgr.PlotRedDotShow)()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityDungeonMainWindow.SetTime = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis
  local data = (ActivityMgr.InitActivityDungeonData)()
  local startTime = (data.baseActivityInfo).beginTime
  local endTime = (data.baseActivityInfo).endTime
  local startStr = (LuaTime.GetFormatTimeStr)("%m-%d %H:%M", startTime)
  local endStr = (LuaTime.GetFormatTimeStr)("%m-%d %H:%M", endTime)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.Time).TimeTxt).text = (PUtil.get)(20000388, startStr, endStr)
end

ActivityDungeonMainWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : ActivityDungeonMainWindow
  (ActivityDungeonMainWindow.SetArrowShow)()
end

ActivityDungeonMainWindow.SetArrowShow = function(...)
  -- function num : 0_7 , upvalues : uis
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.LeftBtn).visible = not ((uis.ChapterList).scrollPane).isLeftMost
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.RightBtn).visible = not ((uis.ChapterList).scrollPane).isRightMost
end

ActivityDungeonMainWindow.OnHide = function(...)
  -- function num : 0_8
end

ActivityDungeonMainWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : uis, contentPane, argTable, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ActivityDungeonMainWindow).name)
end

ActivityDungeonMainWindow.InitAssetStrip = function(...)
  -- function num : 0_10 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ActivityDungeonMainWindow).name
  m.Tip = (PUtil.get)(20000216)
  m.model = uis.AssetStrip
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.ACTIVITY_SCORE}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ActivityDungeonMainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_11 , upvalues : _ENV, ActivityDungeonMainWindow
  if msgId == (WindowMsgEnum.ActivityMainDungeon).E_MSG_SET_TIME then
    (ActivityDungeonMainWindow.SetTime)()
  end
end

return ActivityDungeonMainWindow

