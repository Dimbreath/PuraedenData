-- params : ...
-- function num : 0 , upvalues : _ENV
PlotDungeonService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResStoryInit, PlotDungeonService.OnResStoryInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResStoryReward, PlotDungeonService.OnResStoryReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResSettleStage, PlotDungeonService.OnResSettleStage)
  ;
  (Net.AddListener)((Proto.MsgName).ResInStage, PlotDungeonService.OnResInStage)
  ;
  (Net.AddListener)((Proto.MsgName).ResStorySweep, PlotDungeonService.OnResStorySweep)
  ;
  (Net.AddListener)((Proto.MsgName).ResNextChapterInfo, PlotDungeonService.OnResNextChapterInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResExtraReward, PlotDungeonService.OnResExtraReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResFastSweep, PlotDungeonService.OnResFastSweep)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.OnResStoryInfo = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  print(msg.type)
  ;
  (PlotDungeonMgr.RefreshDungeonData)(msg.chapterInfo, PlotDungeonService.isOpenWindow)
  ;
  (PlotDungeonMgr.RefreshFormation)(msg.cardInfo)
  if PlotDungeonService.isOpenWindow then
    if msg.type == (ProtoEnum.E_CHALLENGE_TYPE).STORE_CHALLENGE then
      OpenWindow((WinResConfig.PlotPlayWindow).name, UILayer.HUD, function(...)
    -- function num : 0_1_0
  end
)
      local storyChapter = msg.chapterInfo
      ;
      (PlotDungeonMgr.CurrentStoryChapter)((storyChapter[#storyChapter]).id)
    else
      do
        if msg.type == (ProtoEnum.E_CHALLENGE_TYPE).ELITE_CHALLENGE then
          OpenWindow((WinResConfig.HeroDungeonWindow).name, UILayer.HUD)
          local storyChapter = msg.chapterInfo
          ;
          (PlotDungeonMgr.CurrentHeroChapter)((storyChapter[#storyChapter]).id)
        else
          do
            if msg.type == DungeonType.ActivityDungeon then
              OpenWindow((WinResConfig.ActivityDungeonMainWindow).name, UILayer.HUD)
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.ReqStoryInfo = function(fbType, notOpenWindow, needResend, ...)
  -- function num : 0_2 , upvalues : _ENV
  local m = {}
  m.type = fbType
  if needResend then
    (Net.Send)((Proto.MsgName).ReqStoryInit, m, (Proto.MsgName).ResStoryInit, function(...)
    -- function num : 0_2_0 , upvalues : _ENV, fbType, notOpenWindow, needResend
    (PlotDungeonService.ReqStoryInfo)(fbType, notOpenWindow, needResend)
  end
)
  else
    ;
    (Net.Send)((Proto.MsgName).ReqStoryInit, m, (Proto.MsgName).ResStoryInit)
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

  PlotDungeonService.isOpenWindow = not notOpenWindow
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.ReqOpenBox = function(stageId, questionNum, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.stageId = stageId
  m.questionNum = questionNum
  ;
  (Net.Send)((Proto.MsgName).ReqStoryReward, m, (Proto.MsgName).ResStoryReward)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.OnResStoryReward = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  local stateId = msg.stageId
  local state = msg.success
  ;
  (MessageMgr.CloseRewardWindow)(stateId, state)
  ;
  (PlotDungeonMgr.ResAwardBox)(msg)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.ReqStartChallenge = function(stageId, cardInfo, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.id = stageId
  m.cardInfo = cardInfo
  ;
  (Net.Send)((Proto.MsgName).ReqInStage, m, (Proto.MsgName).InitBattleData)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.ReqSaveFormation = function(cards, type, ...)
  -- function num : 0_6 , upvalues : _ENV
  local cardInfo = {}
  for i = 1, 6 do
    local common = {}
    if cards[i] then
      common.id = cards[i]
    else
      common.id = 0
    end
    common.value = i
    ;
    (table.insert)(cardInfo, common)
  end
  local m = {}
  m.type = type
  m.cardInfo = cardInfo
  ;
  (Net.Send)((Proto.MsgName).ReqEmbattle, m)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.ReqStorySweep = function(stageId, times, aimItemId, aimNum, ...)
  -- function num : 0_7 , upvalues : _ENV
  local m = {}
  m.stageId = stageId
  m.num = times
  local target = {}
  target.id = aimItemId
  target.value = aimNum
  m.target = target
  ;
  (Net.Send)((Proto.MsgName).ReqStorySweep, m, (Proto.MsgName).ResStorySweep)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.ReqSettleStage = function(battleCompleteData, ...)
  -- function num : 0_8 , upvalues : _ENV
  local cardList = (CardData.GetObtainedCardList)()
  local mTable = {}
  for _,v in ipairs(cardList) do
    (table.insert)(mTable, v.id)
  end
  ;
  (PlotDungeonMgr.TempObtainCardList)(mTable)
  local m = {}
  m.battleCompleteData = battleCompleteData
  ;
  (Net.Send)((Proto.MsgName).ReqSettleStage, m, (Proto.MsgName).ResSettleStage, function(...)
    -- function num : 0_8_0 , upvalues : _ENV, battleCompleteData
    (PlotDungeonService.ReqSettleStage)(battleCompleteData)
  end
)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.OnResSettleStage = function(msg, ...)
  -- function num : 0_9 , upvalues : _ENV
  (PlotDungeonMgr.RefreshCardState)(msg)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.OnResInStage = function(msg, ...)
  -- function num : 0_10
  if not msg.into or not msg.id or msg.cardInfo then
  end
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.OnResStorySweep = function(msg, ...)
  -- function num : 0_11 , upvalues : _ENV
  (PlotDungeonMgr.RefreshStorySweep)(msg, false)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.OnResNextChapterInfo = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  loge("                         open next chapter")
  ;
  (PlotDungeonMgr.RefreshDungeonData)({msg.chapterInfo}, false)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.ReqGetAppendixBox = function(stageId, ...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  m.stageId = stageId
  ;
  (Net.Send)((Proto.MsgName).ReqExtraReward, m, (Proto.MsgName).ResExtraReward)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.OnResExtraReward = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  print("msg.stageId" .. msg.stageId)
  ;
  (MessageMgr.CloseRewardWindow)(msg.stageId, msg.success)
  ;
  (PlotDungeonMgr.ChangeAppendixState)(msg.stageId, msg.success)
  if msg.success then
    local chapter = (PlotDungeonMgr.GetChapterIdByStageID)(msg.stageId)
    local chapterType = (PlotDungeonMgr.GetStageChapterType)(msg.stageId)
    if chapterType == DungeonType.HeroDungeon then
      (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureWindow).name, RedDotComID.Adventure_Hero, chapter)
    else
      if chapterType == DungeonType.BasicDungeon then
        (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureWindow).name, RedDotComID.Adventure_Story, chapter)
      end
    end
  end
  do
    local stageData = ((TableData.gTable).BaseStageData)[msg.stageId]
    ;
    (MessageMgr.OpenRewardByStr)(stageData.ext_reward)
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.OnResFastSweep = function(msg, ...)
  -- function num : 0_15 , upvalues : _ENV
  (PlotDungeonMgr.RefreshStorySweep)(msg, true)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

PlotDungeonService.ReqFastSweep = function(stageIds, ...)
  -- function num : 0_16 , upvalues : _ENV
  local m = {}
  m.stageId = stageIds
  ;
  (Net.Send)((Proto.MsgName).ReqFastSweep, m, (Proto.MsgName).ResFastSweep)
end

;
(PlotDungeonService.init)()

