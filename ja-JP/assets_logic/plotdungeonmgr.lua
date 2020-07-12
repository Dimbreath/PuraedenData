-- params : ...
-- function num : 0 , upvalues : _ENV
PlotDungeonMgr = {}
local self = PlotDungeonMgr
self.chapterInfo = {}
self.stage = {}
AppendixBoxState = {NoCondition = 0, NoBox = 1, Unclaimed = 2, AlreadyGet = 3}
DungeonType = {BasicDungeon = 1, HeroDungeon = 2, ActivityDungeon = 101}
local m = {}
self.stageStates = {}
self.selfFormation = {}
self.SweepData = {}
self.externalFun = {}
self.externalId = {}
self.isQuest = false
-- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.OnClickStage = function(stageId, isEnterNext, aimItemId, aimItemNum, ...)
  -- function num : 0_0 , upvalues : _ENV, self
  local stageId = tonumber(stageId)
  if not stageId or stageId <= 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000039))
    return 
  end
  local stageData = ((TableData.gTable).BaseStageData)[stageId]
  if not stageData then
    return 
  end
  if stageData.type == StageType.FIGHT then
    (PlotDungeonMgr.SetSelectDungeon)(stageData.id, aimItemId, aimItemNum)
  else
    if stageData.type == StageType.STORY then
      if ((self.stageStates)[stageId]).canChange then
        OpenPlotPlay(stageData.id, PlotPlayTriggerType.CLICK_LEVEL_ICON, function(...)
    -- function num : 0_0_0 , upvalues : self, stageId, stageData, _ENV
    if not ((self.stageStates)[stageId]).isGet then
      local battleCompleteData = {}
      battleCompleteData.success = true
      battleCompleteData.damageData = {}
      battleCompleteData.battleData = {}
      battleCompleteData.id = stageData.id
      battleCompleteData.notEnterBattle = true
      ;
      (PlotDungeonService.ReqSettleStage)(battleCompleteData)
    end
  end
)
      else
        local preID = (((TableData.gTable).BaseStageData)[stageId]).pre
        do
          local stageData = ((TableData.gTable).BaseStageData)[preID]
          if (PlotDungeonMgr.GetStageChapterType)(stageId) == DungeonType.HeroDungeon then
            (MessageMgr.SendCenterTips)((PUtil.get)(20000099))
          else
            do
              ;
              (MessageMgr.SendCenterTips)((PUtil.get)(20000059, stageData.remark))
              -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    else
      if stageData.type == StageType.BOX then
        (PlotDungeonMgr.SelectBox)(stageData.id, isEnterNext)
      else
        if stageData.type == StageType.ANSWER then
          if not ((self.stageStates)[stageId]).canChange then
            (MessageMgr.SendCenterTips)((PUtil.get)(20000098))
            return 
          end
          if ((self.stageStates)[stageId]).isGet then
            return 
          end
          local questionList = stageData.question_list
          local qList = split(questionList, ":")
          OpenWindow((WinResConfig.AdventureGame_Question).name, UILayer.HUD, -1, 1, qList, function(rightNum, ...)
    -- function num : 0_0_1 , upvalues : qList, _ENV, stageId
    if #qList == rightNum then
      (PlotDungeonService.ReqOpenBox)(stageId, rightNum)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000304))
    end
  end
)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetAlreadyPassStage = function(chapterId, ...)
  -- function num : 0_1 , upvalues : self, _ENV
  local chapterInfo = (self.chapterInfo)[chapterId]
  if not chapterInfo then
    return 
  end
  local chapterData = ((TableData.gTable).BaseChapterData)[chapterId]
  local StagesStr = split(chapterData.stages, ":")
  for i = 1, #StagesStr do
    local stateId = StagesStr[i]
    if not (PlotDungeonMgr.IsPassDungeon)(tonumber(stateId)) then
      return stateId
    end
  end
  return 0
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetChapterOpenLevel = function(chapterId, ...)
  -- function num : 0_2 , upvalues : _ENV
  local chapterData = ((TableData.gTable).BaseChapterData)[chapterId]
  if chapterData then
    return (PlotDungeonMgr.GetOpenConditionLevel)(chapterData.open_condition)
  end
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetOpenConditionLevel = function(open_condition, ...)
  -- function num : 0_3 , upvalues : _ENV
  if open_condition then
    local condition = (Util.ParseConfigStr)(open_condition)
    for _,v in ipairs(condition) do
      local conditionID = tonumber(v[1])
      local conditionValue = tonumber(v[3])
      if conditionID == ConditionType.PLAYER_LEVEL then
        return conditionValue
      end
    end
  end
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.SetBackHeroChapter = function(ChapterID, ...)
  -- function num : 0_4 , upvalues : self
  self.BackHeroChapter = ChapterID
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetBackHeroChapter = function(...)
  -- function num : 0_5 , upvalues : self
  return self.BackHeroChapter
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.SetSelectDungeon = function(stageId, aimItemId, aimItemNum, ...)
  -- function num : 0_6 , upvalues : self, _ENV
  if ((self.stageStates)[stageId]).canChange and (PlotDungeonMgr.CheckSatisfyContent)(stageId) then
    OpenPlotPlay(stageId, PlotPlayTriggerType.CLICK_LEVEL_ICON, function(...)
    -- function num : 0_6_0 , upvalues : self, stageId, _ENV, aimItemId, aimItemNum
    self.CurrentDungeon = stageId
    if (FunctionControlMgr.GetFunctionState)(ControlID.StageDetail_Panel, false) then
      OpenWindow((WinResConfig.PlotDetailWindow).name, UILayer.HUD, aimItemId, aimItemNum)
    else
      ;
      (PlotDungeonMgr.OnClickChallengeDungeon)()
    end
  end
)
  end
  local preID = (((TableData.gTable).BaseStageData)[stageId]).pre
  local stageData = ((TableData.gTable).BaseStageData)[preID]
  if (PlotDungeonMgr.GetStageChapterType)(stageId) == DungeonType.HeroDungeon then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000098))
  else
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(20000058, stageData.remark))
  end
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.IsFirstChallengeStage = function(stageID, ...)
  -- function num : 0_7 , upvalues : self, _ENV
  if ((self.stageStates)[tonumber(stageID)]).canChange then
    return not ((self.stageStates)[tonumber(stageID)]).isGet
  end
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.IsCanChallenge = function(stageId, showTip, ...)
  -- function num : 0_8 , upvalues : self, _ENV
  if ((self.stageStates)[tonumber(stageId)]).canChange then
    return true
  else
    if showTip then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000022))
    end
    return false
  end
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.SelectBox = function(stageId, isEnterNext, ...)
  -- function num : 0_9 , upvalues : self, _ENV
  if ((self.stageStates)[stageId]).canChange then
    self.CurrentDungeon = stageId
    local stageData = ((TableData.gTable).BaseStageData)[stageId]
    if not ((self.stageStates)[stageId]).isGet then
      local btnData = {}
      btnData.btnTxt = (PUtil.get)(20000010)
      btnData.fun = function(...)
    -- function num : 0_9_0 , upvalues : _ENV, stageId
    (PlotDungeonService.ReqOpenBox)(stageId)
  end

      ;
      (MessageMgr.OpenRewardWindow)(stageData.first_reward, btnData, stageId, (PUtil.get)(20000045))
    else
      do
        do
          if not isEnterNext then
            (MessageMgr.SendCenterTips)((PUtil.get)(20000036))
          else
            ;
            (PlotDungeonMgr.OnClickStage)(stageData.next, isEnterNext)
          end
          local preID = (((TableData.gTable).BaseStageData)[stageId]).pre
          local stageData = ((TableData.gTable).BaseStageData)[preID]
          if (PlotDungeonMgr.GetStageChapterType)(stageId) == DungeonType.HeroDungeon then
            (MessageMgr.SendCenterTips)((PUtil.get)(20000100))
          else
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(20000060, stageData.remark))
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.CheckSatisfyContent = function(stageId, ...)
  -- function num : 0_10 , upvalues : _ENV, self
  local stageId = tonumber(stageId)
  local stageData = ((TableData.gTable).BaseStageData)[stageId]
  if stageData.type == StageType.FIGHT then
    if ((self.stageStates)[stageId]).remindTimes == 0 and (PlotDungeonMgr.IsOnlyOnceState)(stageId) then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000085))
      return false
    else
      if ((self.stageStates)[stageId]).remindTimes <= 0 then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000019))
        return false
      else
        if (ActorData.GetAssetCount)(AssetType.PHYSICAL) < stageData.need_vit then
          (MessageMgr.OpenAssetNotEnoughtWindow)(AssetType.PHYSICAL)
          return false
        end
      end
    end
  end
  return true
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.OnClickChallengeDungeon = function(...)
  -- function num : 0_11 , upvalues : _ENV, self
  local stageData = ((TableData.gTable).BaseStageData)[self.CurrentDungeon]
  if not (PlotDungeonMgr.CheckSatisfyContent)(self.CurrentDungeon) then
    return 
  end
  local formationDataIsOpen = (FunctionControlMgr.GetFunctionState)(ControlID.Formation_Operation, false)
  if not formationDataIsOpen then
    local configStr = split(stageData.cards_list, ":")
    local formation = {}
    for i = 1, 6 do
      local id = tonumber(configStr[i])
      if id > 0 and (CardData.GetCardData)(id) ~= nil then
        formation[i] = id
      else
        formation[i] = nil
      end
    end
    ;
    (PlotDungeonMgr.StartChallenge)(formation)
    return 
  end
  do
    local enemyList = {}
    local groupList = split(stageData.monster_group_list, ":")
    local Battle = ((TableData.gTable).BaseMonsterGroupData)[tonumber(groupList[#groupList])]
    local monsters = split(Battle.monster_list, ":")
    for i = 1, 6 do
      if tonumber(monsters[i]) == 0 then
        enemyList[i] = nil
      else
        enemyList[i] = monsters[i]
      end
    end
    local btnData = {}
    btnData.btnTxt = (PUtil.get)(20000021)
    btnData.fun = PlotDungeonMgr.StartChallenge
    local formationData = {}
    formationData.enemyList = enemyList
    formationData.myselfList = (PlotDungeonMgr.InitSelfFormation)()
    formationData.BtnData = btnData
    formationData.formationType = FormationType.Basic
    formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).STORY
    formationData.stageId = self.CurrentDungeon
    formationData.backFun = function(cards, ...)
    -- function num : 0_11_0 , upvalues : _ENV
    (PlotDungeonService.ReqSaveFormation)(cards, (PlotDungeonMgr.GetDungeonType)())
  end

    formationData.closeFun = function(cards, ...)
    -- function num : 0_11_1 , upvalues : _ENV
    (PlotDungeonService.ReqSaveFormation)(cards, (PlotDungeonMgr.GetDungeonType)())
    ;
    (PlotDungeonMgr.RecodeHeroDungeonPos)(-1)
  end

    ;
    (MessageMgr.OpenFormationWindow)(formationData)
  end
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetDungeonType = function(...)
  -- function num : 0_12 , upvalues : _ENV, self
  if (PlotDungeonMgr.GetStageChapterType)(self.CurrentDungeon) == DungeonType.HeroDungeon then
    return (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_ELITE
  else
    if (PlotDungeonMgr.GetStageChapterType)(self.CurrentDungeon) == DungeonType.BasicDungeon then
      return (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_STORE
    else
      return (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_DEFAULT
    end
  end
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.InitSelfFormation = function(...)
  -- function num : 0_13 , upvalues : self, _ENV
  for i = 1, 6 do
    if (self.selfFormation)[i] then
      return self.selfFormation
    end
  end
  local config = ((TableData.gTable).BaseFixedData)[72000003]
  local configStr = ((Util.ParseConfigStr)(config.array_value))[1]
  local formation = {}
  for i = 1, 6 do
    local id = tonumber(configStr[i])
    if id > 0 and (CardData.GetCardData)(id) ~= nil then
      formation[i] = id
    else
      formation[i] = nil
    end
  end
  return formation
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetSelectDungeon = function(...)
  -- function num : 0_14 , upvalues : self
  return self.CurrentDungeon
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.CurrentStoryChapter = function(chapterID, ...)
  -- function num : 0_15 , upvalues : self
  if chapterID == nil then
    return self.currentStoryChapter
  else
    self.currentStoryChapter = chapterID
  end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.IsQuestHeroData = function(isQuest, ...)
  -- function num : 0_16 , upvalues : self
  if isQuest == nil then
    return self.IsQuestHero
  else
    self.IsQuestHero = isQuest
  end
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.CurrentHeroChapter = function(chapterID, ...)
  -- function num : 0_17 , upvalues : self
  if chapterID == nil then
    return self.currentHeroChapter
  else
    self.currentHeroChapter = chapterID
  end
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetSelectChapter = function(...)
  -- function num : 0_18 , upvalues : self
  return self.CurrentChapter
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.SetSelectChapter = function(chpterID, ...)
  -- function num : 0_19 , upvalues : self
  self.CurrentChapter = chpterID
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.ChapterIsOpen = function(ChapterId, ...)
  -- function num : 0_20 , upvalues : self, _ENV
  do return (self.chapterInfo)[tonumber(ChapterId)] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.CurrentIsPassDungeon = function(...)
  -- function num : 0_21 , upvalues : self
  return ((self.stageStates)[self.CurrentDungeon]).isGet
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.IsPassDungeon = function(stateId, ...)
  -- function num : 0_22 , upvalues : self, _ENV
  if (self.stageStates)[tonumber(stateId)] then
    return ((self.stageStates)[tonumber(stateId)]).isGet
  end
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.CanChangeTimesDungeon = function(...)
  -- function num : 0_23 , upvalues : self
  return ((self.stageStates)[self.CurrentDungeon]).remindTimes
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetCanChangeTimesDungeon = function(stageId, ...)
  -- function num : 0_24 , upvalues : self, _ENV
  return ((self.stageStates)[tonumber(stageId)]).remindTimes
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.IsOnlyGetData = function(...)
  -- function num : 0_25 , upvalues : self
  do return self.externalId ~= nil and #self.externalId > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.ExternalGotoStage = function(dungeonType, stageId, aimItemId, aimItemNum, ...)
  -- function num : 0_26 , upvalues : _ENV, self
  if stageId == nil then
    (PlotDungeonService.ReqStoryInfo)(dungeonType)
    return 
  end
  self.CurrentChapter = (PlotDungeonMgr.GetChapterIdByStageID)(stageId)
  if next(self.stageStates) == nil then
    local stageType = (PlotDungeonMgr.GetStageChapterType)(stageId)
    ;
    (PlotDungeonService.ReqStoryInfo)(stageType, true)
    ;
    (Net.AddOnceListener)((Proto.MsgName).ResStoryInit, PlotDungeonMgr.OpenStage, {stageId, aimItemId, aimItemNum})
  else
    do
      ;
      (PlotDungeonMgr.OpenStage)(stageId, aimItemId, aimItemNum)
    end
  end
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.OpenStage = function(stageId, aimItemId, aimItemNum, ...)
  -- function num : 0_27 , upvalues : _ENV
  (PlotDungeonMgr.OnClickStage)(stageId, false, aimItemId, aimItemNum)
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetChapterIdByStageID = function(stageId, ...)
  -- function num : 0_28 , upvalues : _ENV
  local chapterData = (TableData.gTable).BaseChapterData
  for _,v in pairs(chapterData) do
    local stages = split(v.stages, ":")
    for _,v2 in ipairs(stages) do
      if tonumber(v2) == tonumber(stageId) then
        return v.id
      end
    end
  end
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.ExternalGetStageState = function(chapterType, stageId, fun, ...)
  -- function num : 0_29 , upvalues : _ENV
  if (FunctionControlMgr.GetFunctionState)(chapterType, false) then
    (PlotDungeonMgr.GetStageState)(stageId, fun)
  else
    fun(false, 0, 0)
  end
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetStageState = function(stageId, fun, ...)
  -- function num : 0_30 , upvalues : self, _ENV
  if stageId == nil or fun == nil then
    return 
  end
  local stageData = (self.stageStates)[tonumber(stageId)]
  local stageConfig = ((TableData.gTable).BaseStageData)[tonumber(stageId)]
  if stageConfig and stageData then
    local total = stageConfig.challenge_num
    if total == -1 then
      total = 1
    end
    fun(stageData.canChange, stageData.remindTimes, total)
  else
    do
      fun(false, 0, 0)
    end
  end
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.IsOnlyOnceState = function(stageId, ...)
  -- function num : 0_31 , upvalues : _ENV
  local stageData = ((TableData.gTable).BaseStageData)[tonumber(stageId)]
  do return stageData.challenge_num == -1 and stageData.type == StageType.FIGHT end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.SetInitChapterID = function(storyChapter, ...)
  -- function num : 0_32 , upvalues : _ENV
  (table.sort)(storyChapter, function(a, b, ...)
    -- function num : 0_32_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for _,v in ipairs(storyChapter) do
    local ChapterData = ((TableData.gTable).BaseChapterData)[v.id]
    if ChapterData and ChapterData.type == DungeonType.BasicDungeon then
      local stages = split(ChapterData.stages, ":")
      for _,v2 in ipairs(stages) do
        local boxState = (PlotDungeonMgr.GetAppendixState)(v2)
        if boxState == AppendixBoxState.Unclaimed then
          return v.id
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.RevertDungeonData = function(...)
  -- function num : 0_33 , upvalues : self, _ENV
  self.stageStates = {}
  self.selfFormation = {}
  self.SweepData = {}
  self.externalFun = {}
  self.externalId = {}
  self.isQuest = false
  self.chapterInfo = {}
  self.stage = {}
  ;
  (PlotDungeonMgr.IsQuestHeroData)(false)
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.RefreshDungeonData = function(storyChapter, isInt, ...)
  -- function num : 0_34 , upvalues : _ENV, self
  for _,v in ipairs(storyChapter) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    (self.chapterInfo)[v.id] = v.stageInfo
    for _,v2 in ipairs(v.stageInfo) do
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R12 in 'UnsetPending'

      (self.stage)[v2.id] = v2
    end
    local chapterData = ((TableData.gTable).BaseChapterData)[v.id]
    local stages = split(chapterData.stages, ":")
    for _,v3 in ipairs(stages) do
      local stageData = ((TableData.gTable).BaseStageData)[tonumber(v3)]
      local m = {}
      m.canChange = stageData.pre ~= 0 and (PlotDungeonMgr.includePre)(v.stageInfo, stageData.id)
      if (PlotDungeonMgr.includePre)(v.stageInfo, stageData.id) then
        m.isGet = ((self.stage)[stageData.id]).isGeted
        m.remindTimes = ((self.stage)[stageData.id]).surplusNum
      else
        m.isGet = false
        if stageData.challenge_num == -1 then
          m.remindTimes = 1
        else
          m.remindTimes = stageData.challenge_num
        end
      end
      if (Util.StringIsNullOrEmpty)(stageData.ext_reward) or stageData.ext_reward == tostring(0) then
        m.appendixBox = AppendixBoxState.NoBox
      elseif m.isGet then
        m.appendixBox = ((self.stage)[stageData.id]).extraRewardState
      else
        m.appendixBox = AppendixBoxState.NoCondition
      end
      -- DECOMPILER ERROR at PC106: Confused about usage of register: R16 in 'UnsetPending'

      ;
      (self.stageStates)[stageData.id] = m
    end
  end
  do
    if isInt and not (PlotDungeonMgr.IsOnlyGetData)() then
      local chapterID = (PlotDungeonMgr.SetInitChapterID)(storyChapter)
      if chapterID and chapterID > 0 then
        self.CurrentChapter = chapterID
      else
        self.CurrentChapter = (storyChapter[#storyChapter]).id
      end
    end
    -- DECOMPILER ERROR: 13 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC137: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetAppendixIsCanGet = function(...)
  -- function num : 0_35 , upvalues : _ENV, self
  for _,v in pairs(self.stageStates) do
    if v.appendixBox == AppendixBoxState.Unclaimed then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC140: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.TempObtainCardList = function(cardList, ...)
  -- function num : 0_36 , upvalues : self
  if cardList == nil then
    return self.tempCardList
  else
    self.tempCardList = cardList
  end
end

-- DECOMPILER ERROR at PC143: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.ChangeAppendixState = function(stageId, state, ...)
  -- function num : 0_37 , upvalues : _ENV, self
  if state then
    local chapterType = (PlotDungeonMgr.GetStageChapterType)(stageId)
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

      ((self.stageStates)[stageId]).appendixBox = AppendixBoxState.AlreadyGet
      if chapterType == DungeonType.HeroDungeon then
        UIMgr:SendWindowMessage((WinResConfig.HeroDungeonMainWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_ENEMY_REFRESH)
      else
        UIMgr:SendWindowMessage((WinResConfig.PlotPlayWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_ENEMY_REFRESH, stageId)
      end
      local stageData = ((TableData.gTable).BaseStageData)[tonumber(stageId)]
      local ext = (Util.ParseConfigStr)(stageData.ext_reward)
      local items = {}
      for _,v in pairs(ext) do
        local item = {}
        item.Type = v[1]
        item.id = v[2]
        item.Num = v[3]
        ;
        (table.insert)(items, item)
      end
      ;
      (MessageMgr.OpenRewardShowWindow)(items, function(...)
    -- function num : 0_37_0 , upvalues : _ENV, stageId, chapterType
    local type = (PlotDungeonMgr.GetStageChapterType)(stageId)
    if DungeonType.BasicDungeon == chapterType then
      UIMgr:SendWindowMessage((WinResConfig.PlotPlayWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_NEXT_CHAPTER)
    end
  end
)
    end
  end
end

-- DECOMPILER ERROR at PC146: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetAppendixState = function(stageId, ...)
  -- function num : 0_38 , upvalues : self, _ENV
  if (self.stageStates)[tonumber(stageId)] then
    return ((self.stageStates)[tonumber(stageId)]).appendixBox
  end
end

-- DECOMPILER ERROR at PC149: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.IsFromGetAway = function(stageId, ...)
  -- function num : 0_39 , upvalues : _ENV
  if (PlotDungeonMgr.GetStageChapterType)(stageId) == DungeonType.HeroDungeon and UIMgr:IsWindowInList((WinResConfig.HeroDungeonMainWindow).name) == false then
    return true
  end
  if (PlotDungeonMgr.GetStageChapterType)(stageId) == DungeonType.BasicDungeon and UIMgr:IsWindowInList((WinResConfig.PlotPlayWindow).name) == false then
    return true
  end
  if (PlotDungeonMgr.GetStageChapterType)(stageId) == DungeonType.ActivityDungeon and UIMgr:IsWindowInList((WinResConfig.ActivityDungeonWindow).name) == false then
    return true
  end
  return false
end

-- DECOMPILER ERROR at PC152: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.SettleGotoStage = function(stageID, ...)
  -- function num : 0_40 , upvalues : _ENV
  local stageType = (PlotDungeonMgr.GetStageChapterType)(stageID)
  if stageType == DungeonType.HeroDungeon then
    UIMgr:SetOnShownComplete((WinResConfig.HeroDungeonMainWindow).name, function(...)
    -- function num : 0_40_0 , upvalues : _ENV, stageID
    (PlotDungeonMgr.OnClickStage)(stageID)
  end
)
  else
    if stageType == DungeonType.BasicDungeon then
      UIMgr:SetOnShownComplete((WinResConfig.PlotPlayWindow).name, function(...)
    -- function num : 0_40_1 , upvalues : _ENV, stageID
    (PlotDungeonMgr.OnClickStage)(stageID)
  end
)
    else
      if stageType == DungeonType.ActivityDungeon then
        UIMgr:SetOnShownComplete((WinResConfig.ActivityDungeonWindow).name, function(...)
    -- function num : 0_40_2 , upvalues : _ENV, stageID
    (PlotDungeonMgr.OnClickStage)(stageID)
  end
)
      end
    end
  end
end

-- DECOMPILER ERROR at PC155: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.RefreshCardState = function(msg, ...)
  -- function num : 0_41 , upvalues : _ENV, self
  local curStageId = PlotDungeonMgr.saveStageId
  local isFromGetAway = (PlotDungeonMgr.IsFromGetAway)(curStageId)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if not msg.success then
    PlotDungeonMgr.saveStageId = nil
    if curStageId then
      local btn1Func = function(...)
    -- function num : 0_41_0 , upvalues : _ENV, curStageId
    (PlotDungeonMgr.SettleGotoStage)(curStageId)
    ld("Battle", function(...)
      -- function num : 0_41_0_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
  end

      local m = {}
      m.BattleType = (ProtoEnum.E_BATTLE_TYPE).STORY
      local btn1 = {}
      btn1.btnTxt = (PUtil.get)(20000062)
      btn1.fun = btn1Func
      if isFromGetAway == true then
        btn1 = nil
      end
      m.btn1 = btn1
      ;
      (CommonWinMgr.OpenBattleFailConvergeWindow)(m)
    else
      do
        ld("Battle", function(...)
    -- function num : 0_41_1 , upvalues : _ENV
    (BattleMgr.CloseBattle)()
  end
)
        do return  end
        ;
        (PlotDungeonMgr.RefreshFormation)(msg.cardInfo)
        local stageInfo = msg.stageInfo
        local m = {}
        m.isGet = stageInfo.isGeted
        m.remindTimes = stageInfo.surplusNum
        m.canChange = true
        m.appendixBox = stageInfo.extraRewardState
        -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (self.stageStates)[stageInfo.id] = m
        print(msg.success)
        local nextStage = msg.nextStageInfo
        if nextStage ~= nil and #nextStage > 0 then
          for _,v in ipairs(nextStage) do
            local m2 = {}
            m2.isGet = v.isGeted
            m2.remindTimes = v.surplusNum
            m2.canChange = true
            m2.appendixBox = ((self.stageStates)[v.id]).appendixBox
            -- DECOMPILER ERROR at PC82: Confused about usage of register: R12 in 'UnsetPending'

            ;
            (self.stageStates)[v.id] = m2
          end
          print(" open next stage.......................")
          UIMgr:SendWindowMessage((WinResConfig.PlotPlayWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_ENEMY_REFRESH)
          UIMgr:SendWindowMessage((WinResConfig.ActivityDungeonWindow).name, (WindowMsgEnum.ActivityDungeon).E_MSG_REFRESH)
        end
        local stageData = ((TableData.gTable).BaseStageData)[stageInfo.id]
        do
          if stageData and stageData.type == StageType.STORY then
            local items = {}
            for _,v in ipairs(msg.firstGoods) do
              local item = {}
              item.id = v.id
              item.Num = v.value
              item.Type = v.type
              item.isGet = false
              ;
              (table.insert)(items, item)
            end
            ;
            (MessageMgr.OpenRewardShowWindow)(items, function(...)
    -- function num : 0_41_2 , upvalues : _ENV, stageInfo, stageData
    if (Util.GetChapterIDByStageID)(stageInfo.id) ~= (Util.GetChapterIDByStageID)(stageData.next_stage) then
      OpenPlotPlay((Util.GetChapterIDByStageID)(stageInfo.id), PlotPlayTriggerType.CHAPTER_COMPLETE, function(...)
      -- function num : 0_41_2_0 , upvalues : _ENV
      UIMgr:SendWindowMessage((WinResConfig.PlotPlayWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_CHECK_PASS_PROCESS)
    end
)
    else
      UIMgr:SendWindowMessage((WinResConfig.PlotPlayWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_CHECK_PASS_PROCESS)
    end
  end
)
            UIMgr:SendWindowMessage((WinResConfig.HeroDungeonMainWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_SET_LIST)
            UIMgr:SendWindowMessage((WinResConfig.PlotPlayWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_ENEMY_REFRESH, true)
            UIMgr:SendWindowMessage((WinResConfig.ActivityDungeonWindow).name, (WindowMsgEnum.ActivityDungeon).E_MSG_REFRESH)
            return 
          end
          local SettleWinData = {}
          SettleWinData.BattleType = (ProtoEnum.E_BATTLE_TYPE).STORY
          SettleWinData.CardAddExp = msg.exp
          SettleWinData.CardAddIntimacy = stageData.card_intimacy
          SettleWinData.TeamAddExp = stageData.player_exp
          SettleWinData.BasicGoods = (Util.GoodsObjectToItemDataModel)(msg.goodsObjs)
          SettleWinData.FirstGoods = (Util.GoodsObjectToItemDataModel)(msg.firstGoods)
          local isShowNext = stageData.next_button_show == 1
          if stageData.next_button_show == 2 then
            isShowNext = not msg.isFirst
          end
          do
            if isShowNext and isFromGetAway == false then
              local btn2 = {}
              btn2.btnTxt = (PUtil.get)(20000024)
              btn2.fun = function(...)
    -- function num : 0_41_3 , upvalues : _ENV, stageData, msg
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      (PlotDungeonMgr.SettleGotoStage)(stageData.next_stage)
      ld("Battle", function(...)
      -- function num : 0_41_3_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    else
      UIMgr:CloseWindow((WinResConfig.BattleWinConvergeWindow).name)
      ;
      (PlotDungeonMgr.OnClickStage)((msg.nextStageInfo).id, true)
    end
  end

              SettleWinData.btn1 = btn2
            end
            local btn3 = {}
            if isFromGetAway ~= true or not (PUtil.get)(30) then
              btn3.btnTxt = (PUtil.get)(20000025)
              btn3.fun = function(...)
    -- function num : 0_41_4 , upvalues : _ENV, msg, curStageId
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      if (PlotDungeonMgr.GetStageChapterType)((msg.stageInfo).id) == DungeonType.HeroDungeon then
        UIMgr:SetOnShownComplete((WinResConfig.HeroDungeonMainWindow).name, function(...)
      -- function num : 0_41_4_0 , upvalues : _ENV, msg
      OpenPlotPlay((msg.stageInfo).id, PlotPlayTriggerType.AFTER_QUIT_LEVEL, function(...)
        -- function num : 0_41_4_0_0 , upvalues : msg, _ENV
        if msg.isFirst then
          UIMgr:SendWindowMessage((WinResConfig.HeroDungeonMainWindow).name, (WindowMsgEnum.HeroDungeonMainWindow).E_MSG_PASS_CHAPTER)
        end
      end
)
      ;
      (FunctionControlMgr.OpenFunctionWindow)()
    end
)
      else
        if (PlotDungeonMgr.GetStageChapterType)((msg.stageInfo).id) == DungeonType.BasicDungeon then
          UIMgr:SetOnShownComplete((WinResConfig.PlotPlayWindow).name, function(...)
      -- function num : 0_41_4_1 , upvalues : _ENV, msg, curStageId
      OpenPlotPlay((msg.stageInfo).id, PlotPlayTriggerType.AFTER_QUIT_LEVEL)
      if (Util.GetChapterIDByStageID)((msg.stageInfo).id) ~= (Util.GetChapterIDByStageID)((((TableData.gTable).BaseStageData)[(msg.stageInfo).id]).next_stage) then
        OpenPlotPlay((Util.GetChapterIDByStageID)((msg.stageInfo).id), PlotPlayTriggerType.CHAPTER_COMPLETE)
      end
      ;
      (FunctionControlMgr.OpenFunctionWindow)()
      if msg.isFirst then
        UIMgr:SendWindowMessage((WinResConfig.PlotPlayWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_PLAY_DIE, curStageId)
      end
    end
)
        else
          if (PlotDungeonMgr.GetStageChapterType)((msg.stageInfo).id) == DungeonType.ActivityDungeon then
            UIMgr:SetOnShownComplete((WinResConfig.ActivityDungeonWindow).name, function(...)
      -- function num : 0_41_4_2 , upvalues : msg, _ENV
      local stageID = (msg.stageInfo).id
      OpenPlotPlay((msg.stageInfo).id, PlotPlayTriggerType.AFTER_QUIT_LEVEL)
      local RecordData = ((TableData.gTable).BaseHandbookAdventureRecordData)[stageID]
      if msg.isFirst and RecordData ~= nil then
        (Util.SetPlayerSetting)(PlayerPrefsKeyName.ACTIVITY_DUNGEON_PLOT_DOT, stageID)
        ;
        (MessageMgr.OpenConfirmWindow)((PUtil.get)(20000494, RecordData.sort), function(...)
        -- function num : 0_41_4_2_0 , upvalues : _ENV, stageID
        local acID = (ActivityMgr.GetOpenActivityByType)((ActivityMgr.ActivityType).ActivityDungeon)
        local ActivityData = ((TableData.gTable).BaseActivityData)[acID]
        ;
        (HandBookService.OnReqAdventureStoryChapter)((ProtoEnum.E_BATTLE_TYPE).ACTIVITY, ActivityData.story_type, stageID)
      end
)
      end
      UIMgr:SendWindowMessage((WinResConfig.ActivityDungeonWindow).name, (WindowMsgEnum.ActivityDungeon).E_MSG_REFRESH_RED)
    end
)
          end
        end
      end
      ld("Battle", function(...)
      -- function num : 0_41_4_3 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    else
      UIMgr:CloseWindow((WinResConfig.BattleWinConvergeWindow).name)
    end
  end

              SettleWinData.btn2 = btn3
              ;
              (CommonWinMgr.OpenBattleSettleConvergeWindow)(SettleWinData)
              -- DECOMPILER ERROR: 5 unprocessed JMP targets
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC158: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.TempCreateSummarize = function(...)
  -- function num : 0_42 , upvalues : _ENV
  local ChallengeSummarizeDataTable = (BattleResultCount.GetBattleDamageData)()
  ;
  (CommonWinMgr.OpenBattleDataWindow)(ChallengeSummarizeDataTable)
end

-- DECOMPILER ERROR at PC161: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.RefreshFormation = function(formationInfo, ...)
  -- function num : 0_43 , upvalues : _ENV, self
  for _,v in ipairs(formationInfo) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    if v.id <= 0 then
      (self.selfFormation)[v.value] = nil
    else
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self.selfFormation)[v.value] = v.id
    end
  end
end

-- DECOMPILER ERROR at PC164: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetSelfFormation = function(...)
  -- function num : 0_44 , upvalues : self
  return self.selfFormation
end

-- DECOMPILER ERROR at PC167: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetEnemyFormation = function(...)
  -- function num : 0_45 , upvalues : self
  return self.enemyFormation
end

-- DECOMPILER ERROR at PC170: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.includePre = function(vs, pre, ...)
  -- function num : 0_46 , upvalues : _ENV
  for _,v in ipairs(vs) do
    if v.id == pre then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC173: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.StartChallenge = function(cards, ...)
  -- function num : 0_47 , upvalues : _ENV, self
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
  ;
  (PlotDungeonService.ReqStartChallenge)(self.CurrentDungeon, cardInfo)
end

-- DECOMPILER ERROR at PC176: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.RefreshStorySweep = function(msg, isFastSweep, ...)
  -- function num : 0_48 , upvalues : _ENV, self
  local goods = {}
  for _,v in ipairs(msg.goodsLists) do
    local m = {}
    m.exp = v.exp
    local items = {}
    for _,v2 in ipairs(v.goodsObjs) do
      if v2.id == AssetType.GOLD then
        m.money = v2.value
      end
      local item = {}
      item.id = v2.id
      item.Num = v2.value
      item.Type = v2.type
      ;
      (table.insert)(items, item)
    end
    m.items = items
    ;
    (table.insert)(goods, m)
  end
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.SweepData).getItems = goods
  if isFastSweep then
    for _,v in ipairs(msg.stageInfo) do
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

      ((self.stageStates)[v.id]).remindTimes = v.surplusNum
    end
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.SweepData).isFastWeep = true
  else
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.stageStates)[msg.stageId]).remindTimes = (msg.stageInfo).surplusNum
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.SweepData).isFastWeep = false
  end
  local win = UIMgr:GetWindow((WinResConfig.ClearingWindow).name)
  if win and win.isShowing then
    UIMgr:SendWindowMessage((WinResConfig.ClearingWindow).name, (WindowMsgEnum.ClearingWindow).E_MSG_REWARD_REFRESH)
  else
    UIMgr:CloseWindow((WinResConfig.PlotDetailWindow).name)
    OpenWindow((WinResConfig.ClearingWindow).name, UILayer.HUD)
  end
  if isFastSweep or (PlotDungeonMgr.GetStageChapterType)((msg.stageInfo).id) == DungeonType.HeroDungeon then
    UIMgr:SendWindowMessage((WinResConfig.HeroDungeonMainWindow).name, (WindowMsgEnum.HeroDungeonMainWindow).E_MSG_REFRESH)
  end
end

-- DECOMPILER ERROR at PC179: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.ResAwardBox = function(msg, ...)
  -- function num : 0_49 , upvalues : self, _ENV, m
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.stageStates)[msg.stageId]).isGet = msg.success
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  if ((self.stageStates)[msg.stageId]).appendixBox == AppendixBoxState.NoCondition and msg.success then
    ((self.stageStates)[msg.stageId]).appendixBox = AppendixBoxState.Unclaimed
  end
  local nextStageInfo = msg.nextStageInfo
  if nextStageInfo and #nextStageInfo > 0 then
    for _,v in ipairs(nextStageInfo) do
      m = {}
      m.isGet = v.isGeted
      m.remindTimes = v.surplusNum
      m.canChange = true
      m.appendixBox = ((self.stageStates)[v.id]).appendixBox
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.stageStates)[v.id] = m
    end
    if (PlotDungeonMgr.GetStageChapterType)(msg.stageId) == DungeonType.HeroDungeon then
      UIMgr:SendWindowMessage((WinResConfig.HeroDungeonMainWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_SET_LIST)
    else
      if (PlotDungeonMgr.GetStageChapterType)(msg.stageId) == DungeonType.BasicDungeon then
        UIMgr:SendWindowMessage((WinResConfig.PlotPlayWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_ENEMY_REFRESH, (msg.nextStageInfo).id)
      else
        if (PlotDungeonMgr.GetStageChapterType)(msg.stageId) == DungeonType.ActivityDungeon then
          UIMgr:SendWindowMessage((WinResConfig.ActivityDungeonWindow).name, (WindowMsgEnum.ActivityDungeon).E_MSG_REFRESH)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC182: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetStageChapterType = function(stageID, ...)
  -- function num : 0_50 , upvalues : _ENV
  local StageData = ((TableData.gTable).BaseStageData)[stageID]
  if StageData then
    return StageData.chapter_type
  end
end

-- DECOMPILER ERROR at PC185: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.StartSweep = function(stageId, times, aimItemId, aimNum, ...)
  -- function num : 0_51 , upvalues : _ENV, self
  if not (PlotDungeonMgr.IsPassDungeon)(stageId) then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000057))
    return 
  end
  ;
  (EquiptMgr.CheckShowEquipBagConfirm)(EquiptAcquireType.Dungeon, function(...)
    -- function num : 0_51_0 , upvalues : _ENV, stageId, self, aimItemId, aimNum, times
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

    if (PlotDungeonMgr.CheckSatisfyContent)(stageId) then
      (self.SweepData).stageId = stageId
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (self.SweepData).aimItemId = aimItemId
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (self.SweepData).aimNum = aimNum
      ;
      (PlotDungeonService.ReqStorySweep)(stageId, times, aimItemId, aimNum)
    end
  end
, (((TableData.gTable).BaseStageData)[stageId]).sweep_reward)
end

-- DECOMPILER ERROR at PC188: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.FastSweep = function(debris, stages, ...)
  -- function num : 0_52 , upvalues : self, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.SweepData).debrisS = debris
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.SweepData).stageId = stages[1]
  ;
  (PlotDungeonService.ReqFastSweep)(stages)
end

-- DECOMPILER ERROR at PC191: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.GetSweepData = function(...)
  -- function num : 0_53 , upvalues : self
  return self.SweepData
end

-- DECOMPILER ERROR at PC194: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.RecodeHeroDungeonPos = function(pos, ...)
  -- function num : 0_54 , upvalues : self
  if pos then
    self.heroChallengeId = pos
  else
    return self.heroChallengeId
  end
end

-- DECOMPILER ERROR at PC197: Confused about usage of register: R2 in 'UnsetPending'

PlotDungeonMgr.ActivityDungeonRecodeID = function(id, ...)
  -- function num : 0_55 , upvalues : self
  if id then
    self.ActivityDungeonRecode = id
  else
    return self.ActivityDungeonRecode
  end
end


