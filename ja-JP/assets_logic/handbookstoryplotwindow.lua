-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_StoryPlotByName")
local HandBookStoryPlotWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local chapterS = {}
local stageList = {}
local chapterIndex = 1
local selectIndex = 0
HandBookStoryPlotWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HandBookStoryPlotWindow, chapterS
  bridgeObj:SetView((WinResConfig.HandBookStoryPlotWindow).package, (WinResConfig.HandBookStoryPlotWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetHandBook_StoryPlotUis(contentPane)
  ;
  (HandBookStoryPlotWindow.InitAssetStrip)()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.StoryPlotChapterList).itemRenderer = HandBookStoryPlotWindow.OnRenderChapterList
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.DetailsList).itemRenderer = HandBookStoryPlotWindow.OnRenderDetailList
  ;
  (uis.DetailsList):SetVirtual()
  ;
  (uis.DetailsList):SetBeginAnim(false, "up", 0.1, 0.1, true)
  local chapterData = nil
  local openType = argTable[1]
  if openType == (HandBookMgr.AdventureStoryType).MainStory then
    chapterData = (HandBookMgr.GetChapter)((HandBookMgr.AdventureStoryType).MainStory)
    for _,v in ipairs(chapterData) do
      if (HandBookMgr.ChapterIsUnlock)(v.id) then
        (table.insert)(chapterS, v)
      end
    end
  else
    do
      if openType == (HandBookMgr.AdventureStoryType).Activity then
        local activityType = tonumber(argTable[2])
        local ActivityChapterList = (HandBookMgr.GetChapterActivityType)()
        local chapterList = ActivityChapterList[activityType]
        for _,v2 in ipairs(chapterList) do
          if (HandBookMgr.ActivityChapterIsUnlock)(v2.id) then
            (table.insert)(chapterS, v2)
          end
        end
        ;
        (Util.SetPlayerSetting)(PlayerPrefsKeyName.ACTIVITY_DUNGEON_PLOT_DOT, 0)
      end
      do
        -- DECOMPILER ERROR at PC105: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.StoryPlotChapterList).numItems = #chapterS
        ;
        (LuaSound.PlaySound)(LuaSound.COMMON_SLIDE_2, SoundBank.OTHER)
        if argTable[3] and argTable[3] > 0 then
          local RecordID = argTable[3]
          local num = (HandBookStoryPlotWindow.GetRecordIDPos)(RecordID)
          ;
          (HandBookStoryPlotWindow.OnSelectChapter)(num)
        else
          do
            ;
            (HandBookStoryPlotWindow.OnSelectChapter)(1)
          end
        end
      end
    end
  end
end

HandBookStoryPlotWindow.GetRecordIDPos = function(id, ...)
  -- function num : 0_1 , upvalues : _ENV, chapterS
  for i,v in ipairs(chapterS) do
    local record_ids = split(v.record_ids, ":")
    for _,v2 in ipairs(record_ids) do
      if id == tonumber(v2) then
        return i
      end
    end
  end
end

HandBookStoryPlotWindow.ChapterIsUnlock = function(id, ...)
  -- function num : 0_2 , upvalues : argTable, _ENV
  local openType = argTable[1]
  if openType == (HandBookMgr.AdventureStoryType).MainStory then
    return (HandBookMgr.ChapterIsUnlock)(id)
  else
    if openType == (HandBookMgr.AdventureStoryType).Activity then
      return (HandBookMgr.ActivityChapterIsUnlock)(id)
    end
  end
end

HandBookStoryPlotWindow.OnRenderChapterList = function(index, obj, ...)
  -- function num : 0_3 , upvalues : chapterS, _ENV, HandBookStoryPlotWindow, chapterIndex
  index = index + 1
  local data = chapterS[index]
  ;
  (obj:GetChild("NameTxt")).text = (PUtil.get)(20000127, index)
  ;
  (obj:GetChild("WordTxt")).text = data.name
  local line = obj:GetChild("StoryLine")
  line.visible = index < #chapterS
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : HandBookStoryPlotWindow, data, chapterIndex, index, _ENV
    -- DECOMPILER ERROR at PC11: Unhandled construct in 'MakeBoolean' P1

    if (HandBookStoryPlotWindow.ChapterIsUnlock)(data.id) and chapterIndex ~= index then
      (HandBookStoryPlotWindow.OnSelectChapter)(index)
    end
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(20000251))
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HandBookStoryPlotWindow.OnRenderDetailList = function(index, obj, ...)
  -- function num : 0_4 , upvalues : _ENV, stageList
  obj = obj:GetChild("DetailsGrp")
  index = index + 1
  local stageId = tonumber(stageList[index])
  if (HandBookMgr.AdventureStoryStageIsOpen)(stageId) then
    ChangeUIController(obj, "c1", 0)
    ChangeUIController(obj:GetChild("DetailsIconGrp"), "c1", 0)
  else
    ChangeUIController(obj, "c1", 1)
    ChangeUIController(obj:GetChild("DetailsIconGrp"), "c1", 1)
  end
  local RecordData = ((TableData.gTable).BaseHandbookAdventureRecordData)[stageId]
  local bg = (obj:GetChild("DetailsIconGrp")):GetChild("IconImage")
  bg.url = (Util.GetItemUrl)(RecordData.icon)
  bg.fill = 5
  ;
  (obj:GetChild("NumberTxt")).text = (PUtil.get)(20000249, index)
  ;
  (obj:GetChild("WordTxt")).text = RecordData.remark
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV, stageId, RecordData
    if (HandBookMgr.AdventureStoryStageIsOpen)(stageId) then
      OpenPlotPlay(RecordData.story_id, PlotPlayTriggerType.INSTANTLY_PLAY)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000252))
    end
  end
)
end

HandBookStoryPlotWindow.OnSelectChapter = function(index, ...)
  -- function num : 0_5 , upvalues : chapterS, chapterIndex, stageList, _ENV, uis
  local chapterData = chapterS[index]
  chapterIndex = index
  stageList = split(chapterData.record_ids, ":")
  ;
  (HandBookService.OnReqAdventureStoryStage)(chapterData.id)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.StoryPlotChapterList).selectedIndex = index - 1
  ;
  (Util.SetOnClickDelay)(0.5)
end

HandBookStoryPlotWindow.OnShown = function(...)
  -- function num : 0_6
end

HandBookStoryPlotWindow.OnHide = function(...)
  -- function num : 0_7
end

HandBookStoryPlotWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis, contentPane, argTable, chapterS, stageList, chapterIndex
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookStoryPlotWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
  chapterS = {}
  stageList = {}
  chapterIndex = 1
end

HandBookStoryPlotWindow.InitAssetStrip = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.HandBookStoryPlotWindow).name
  m.Tip = (PUtil.get)(20000128)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HandBookMainWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookStoryPlotWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_10 , upvalues : uis, stageList, _ENV, selectIndex
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  if msgId == 1 then
    (uis.DetailsList).numItems = #stageList
    ;
    (LuaSound.PlaySound)(LuaSound.COMMON_SLIDE_2, SoundBank.OTHER)
  else
    if msgId == 2 then
      ChangeController((uis.StoryPlotChoiceButtonGrp).c1Ctr, selectIndex)
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000381))
    end
  end
end

return HandBookStoryPlotWindow

