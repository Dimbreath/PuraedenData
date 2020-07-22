-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuideTips_GuideTipsWindowByName")
local GuideTipsWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _duringMoving = nil
local _entranceTimestamp = {}
local _needShowNext = false
local _lastShowTimestamp = nil
GuideTipsWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuideTipsWindow
  bridgeObj:SetView((WinResConfig.GuideTipsWindow).package, (WinResConfig.GuideTipsWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuideTips_GuideTipsWindowUis(contentPane)
  ;
  (GuideTipsWindow.InitVariable)()
  ;
  (GuideTipsWindow.InitText)()
  ;
  (GuideTipsWindow.InitButtonEvent)()
end

GuideTipsWindow.InitVariable = function(...)
  -- function num : 0_1
end

GuideTipsWindow.InitText = function(...)
  -- function num : 0_2
end

GuideTipsWindow.InitButtonEvent = function(...)
  -- function num : 0_3
end

GuideTipsWindow.InitEvent = function(...)
  -- function num : 0_4
end

GuideTipsWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

GuideTipsWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : GuideTipsWindow
  (GuideTipsWindow.InitEvent)()
  ;
  (GuideTipsWindow.Init)()
end

GuideTipsWindow.OnHide = function(...)
  -- function num : 0_7
end

GuideTipsWindow.Init = function(...)
  -- function num : 0_8 , upvalues : GuideTipsWindow
  (GuideTipsWindow.ShowNextTip)()
end

GuideTipsWindow.ShowNextTip = function(...)
  -- function num : 0_9 , upvalues : uis, _ENV, _lastShowTimestamp, _duringMoving, GuideTipsWindow, _entranceTimestamp
  if uis == nil or GuideTipsData.MAX_DISPLAY_AMOUNT <= (uis.TipsList).numChildren then
    loge("reach max")
    return 
  end
  if _lastShowTimestamp ~= nil and (math.floor)(((ActorData.GetServerTime)() - _lastShowTimestamp) * 100) < GuideTipsData.INTERVAL * 10 then
    loge("_lastShowTimestamp")
    return 
  end
  if _duringMoving then
    loge("_duringMoving")
    return 
  end
  local data = (GuideTipsMgr.Dequeue)()
  if data == nil then
    loge("no more")
    return 
  end
  loge("waiting:" .. #GuideTipsData.WaitingQueue)
  _lastShowTimestamp = (ActorData.GetServerTime)()
  local item = (uis.TipsList):AddItemFromPool()
  ;
  (GuideTipsWindow.SetContent)(item, data)
  local index = (uis.TipsList).numChildren
  local transition = item:GetTransition("inout")
  loge("Play:" .. index)
  transition:Play()
  ;
  ((FairyGUI.Timers).inst):Add(0.5, 1, function(...)
    -- function num : 0_9_0 , upvalues : item, _ENV, _entranceTimestamp, index, GuideTipsWindow
    local com = item:GetChild("GuideTips")
    com.alpha = 1
    com.xy = Vector2.zero
    _entranceTimestamp[item.uid] = (LuaTime.GetTimeStamp)()
    loge("finish:" .. index)
    if index == 1 then
      ((FairyGUI.Timers).inst):Add(GuideTipsData.DISPLAY_DURATION, 1, function(obj, ...)
      -- function num : 0_9_0_0 , upvalues : _ENV, index, GuideTipsWindow
      loge("index QuitTopTip:" .. index)
      ;
      (GuideTipsWindow.QuitTopTip)()
    end
)
    end
  end
)
  ;
  ((FairyGUI.Timers).inst):Add(GuideTipsData.INTERVAL, 1, function(obj, ...)
    -- function num : 0_9_1 , upvalues : _ENV, index, GuideTipsWindow
    loge("index ShowNextTip:" .. index)
    ;
    (GuideTipsWindow.ShowNextTip)()
  end
)
end

GuideTipsWindow.QuitTopTip = function(...)
  -- function num : 0_10 , upvalues : uis, _ENV, _duringMoving, _entranceTimestamp, GuideTipsWindow
  local item = (uis.TipsList):GetChildAt(0)
  local transition = item:GetTransition("inout")
  loge("recycle")
  transition:PlayReverse()
  ;
  ((FairyGUI.Timers).inst):Add(0.5, 1, function(obj, ...)
    -- function num : 0_10_0 , upvalues : _ENV, item, uis, _duringMoving, _entranceTimestamp, GuideTipsWindow
    loge("PlayReverse finish")
    local uid = item.uid
    ;
    (uis.TipsList):RemoveChildToPoolWithoutResort(item)
    local count = (uis.TipsList).numChildren
    loge("count:" .. count)
    _duringMoving = true
    for i = 0, count - 1 do
      local index = i
      do
        local finalCount = count - 1
        local run = false
        local onComplete = function(...)
      -- function num : 0_10_0_0 , upvalues : run, _ENV, index, finalCount, _duringMoving, _entranceTimestamp, uid, item, uis, GuideTipsWindow
      if run then
        return 
      end
      loge("index TweenMove finish:" .. index .. " finalCount:" .. finalCount)
      run = true
      if index == finalCount then
        _duringMoving = false
        _entranceTimestamp[uid] = nil
        item = (uis.TipsList):GetChildAt(0)
        if _entranceTimestamp[item.uid] ~= nil then
          local passedTime = (LuaTime.GetTimeStamp)() - _entranceTimestamp[item.uid]
          loge("passedTime:" .. passedTime)
          if GuideTipsData.DISPLAY_DURATION <= passedTime then
            (GuideTipsWindow.QuitTopTip)()
          else
            ;
            ((FairyGUI.Timers).inst):Add(GuideTipsData.DISPLAY_DURATION - passedTime, 1, function(obj, ...)
        -- function num : 0_10_0_0_0 , upvalues : GuideTipsWindow
        (GuideTipsWindow.QuitTopTip)()
      end
)
          end
          ;
          (GuideTipsWindow.ShowNextTip)()
        else
          do
            ;
            (GuideTipsWindow.QuitTopTip)()
            ;
            (GuideTipsWindow.ShowNextTip)()
          end
        end
      end
    end

        ;
        ((uis.TipsList):GetChildAt(i)):TweenMoveY(i * (item.height + (uis.TipsList).lineGap), GuideTipsData.INTERVAL)
        ;
        ((FairyGUI.Timers).inst):Add(GuideTipsData.INTERVAL, 1, function(obj, ...)
      -- function num : 0_10_0_1 , upvalues : onComplete
      onComplete()
    end
)
      end
    end
    if count == 0 then
      UIMgr:CloseWindow((WinResConfig.GuideTipsWindow).name)
    end
  end
)
end

GuideTipsWindow.SetContent = function(item, data, ...)
  -- function num : 0_11 , upvalues : _ENV
  local config = (GuideTipsData.GetConfigData)(data.Type)
  item = item:GetChild("GuideTips")
  ;
  (item:GetChild("IconLoader")).url = (Util.GetItemUrl)(config.icon)
  if data.Type == GuideTipsCheckPoint.AcquireCharacter or data.Type == GuideTipsCheckPoint.AcquireCharacterCG or data.Type == GuideTipsCheckPoint.UnlockBackgroundStory or data.Type == GuideTipsCheckPoint.UnlockCV or data.Type == GuideTipsCheckPoint.UnlockDailyDungeon or data.Type == GuideTipsCheckPoint.UnlockStorySlots or data.Type == GuideTipsCheckPoint.AcquireStoryRoleCG or data.Type == GuideTipsCheckPoint.UnlockAdventureStore or data.Type == GuideTipsCheckPoint.UnlockHeroStore or data.Type == GuideTipsCheckPoint.MergeItem or data.Type == GuideTipsCheckPoint.UnlcokFeelingStory then
    (item:GetChild("Word_01_Txt")).text = (PUtil.get)(config.name, (data.Args)[1])
    ;
    (item:GetChild("Word_02_Txt")).text = (PUtil.get)(config.remark)
  else
    if data.Type == GuideTipsCheckPoint.BreakThrough or data.Type == GuideTipsCheckPoint.PlotPlay or data.Type == GuideTipsCheckPoint.QuestComplete or data.Type == GuideTipsCheckPoint.AcquireFeelingTitle then
      (item:GetChild("Word_01_Txt")).text = (PUtil.get)(config.name, (data.Args)[1])
      ;
      (item:GetChild("Word_02_Txt")).text = (PUtil.get)(config.remark, (data.Args)[2])
    else
    end
  end
  -- DECOMPILER ERROR at PC184: Unhandled construct in 'MakeBoolean' P3

  -- DECOMPILER ERROR at PC184: Unhandled construct in 'MakeBoolean' P3

  -- DECOMPILER ERROR at PC184: Unhandled construct in 'MakeBoolean' P3

  -- DECOMPILER ERROR at PC184: Unhandled construct in 'MakeBoolean' P3

  -- DECOMPILER ERROR at PC184: Unhandled construct in 'MakeBoolean' P3

  -- DECOMPILER ERROR at PC184: Unhandled construct in 'MakeBoolean' P3

  if (data.Type == GuideTipsCheckPoint.AcquireBackgroundCG and data.Type == GuideTipsCheckPoint.UnlockStoryChapter) or data.Type == GuideTipsCheckPoint.UnlockExpedition then
    (item:GetChild("Word_01_Txt")).text = (PUtil.get)(config.name)
    ;
    (item:GetChild("Word_02_Txt")).text = (PUtil.get)(config.remark, (data.Args)[1])
  else
    if data.Type == GuideTipsCheckPoint.UnlockAssaultLeader or data.Type == GuideTipsCheckPoint.UnlockAssaultTheif or data.Type == GuideTipsCheckPoint.UnlockChallengeMage or data.Type == GuideTipsCheckPoint.UnlockNewTower or data.Type == GuideTipsCheckPoint.AdventrureWish or data.Type == GuideTipsCheckPoint.UnlockNewFetter or data.Type == GuideTipsCheckPoint.UnlockHandBookStory or data.Type == GuideTipsCheckPoint.AutoSkillLvlUp then
      (item:GetChild("Word_01_Txt")).text = (PUtil.get)(config.name)
      ;
      (item:GetChild("Word_02_Txt")).text = (PUtil.get)(config.remark)
    end
  end
end

GuideTipsWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : GuideTipsWindow, uis, contentPane, argTable, _duringMoving, _entranceTimestamp, _needShowNext
  (GuideTipsWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
  _duringMoving = false
  _entranceTimestamp = {}
  _needShowNext = false
end

GuideTipsWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : _ENV, GuideTipsWindow
  if msgId == (WindowMsgEnum.GuideTips).E_MSG_SHOW_TIPS then
    (GuideTipsWindow.ShowNextTip)()
  end
end

return GuideTipsWindow

