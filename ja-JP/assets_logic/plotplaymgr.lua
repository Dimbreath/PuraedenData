-- params : ...
-- function num : 0 , upvalues : _ENV
PlotPlayMgr = {}
local _callback = nil
-- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

PlotPlayMgr.OpenMainUI = function(...)
  -- function num : 0_0 , upvalues : _ENV
  if UIMgr:IsWindowOpen((WinResConfig.PlotPlayPanelWindow).name) == false then
    OpenWindow((WinResConfig.PlotPlayPanelWindow).name, UILayer.HUD1)
  end
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

PlotPlayMgr.Play = function(triggerID, triggerType, callback, notShowSwitchBtn, ...)
  -- function num : 0_1 , upvalues : _ENV, _callback
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  PlotPlayData.NotShowSwitchBtn = notShowSwitchBtn
  ;
  (PlotPlayData.InitData)()
  _callback = callback
  if (PlotPlayMgr.InitMainPlotQueue)(triggerID, triggerType) or OvertureMgr.isPlaying then
    (PlotPlayMgr.PlayNextPlot)()
  end
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

PlotPlayMgr.InitMainPlotQueue = function(triggerID, triggerType, ...)
  -- function num : 0_2 , upvalues : _ENV
  local ids, times, config = nil, nil, nil
  local noNeedQuery = true
  if triggerType == PlotPlayTriggerType.INSTANTLY_PLAY then
    ids = triggerID
    times = {}
  else
    if triggerType == PlotPlayTriggerType.CHAPTER_UNLOCK or triggerType == PlotPlayTriggerType.CHAPTER_COMPLETE then
      config = ((TableData.gTable).BaseChapterData)[triggerID]
    else
      if triggerType == PlotPlayTriggerType.CLICK_LEVEL_ICON or triggerType == PlotPlayTriggerType.ENTER_BATTLE or triggerType == PlotPlayTriggerType.BEFORE_VICTORY or triggerType == PlotPlayTriggerType.AFTER_QUIT_LEVEL then
        config = ((TableData.gTable).BaseStageData)[triggerID]
        if config == nil then
          config = ((TableData.gTable).BaseHandbookStageData)[triggerID]
        end
      else
        if triggerType == PlotPlayTriggerType.BEFORE_ROUND_START or triggerType == PlotPlayTriggerType.AFTER_ROUND_END then
          config = ((TableData.gTable).BaseMonsterGroupData)[triggerID]
        end
      end
    end
    if config == nil then
      return noNeedQuery
    end
    ids = config.story_id
    times = split(config.story_times, ":")
  end
  ids = split(ids, ":")
  local count = #times
  local index = 1
  for i = 1, count do
    if tonumber(times[i]) == triggerType then
      index = i
      break
    end
  end
  do
    local need = nil
    count = #ids
    local subConfig, id = nil, nil
    local needQuery = {}
    for i = index, count do
      if times[i] == nil or tonumber(times[i]) == triggerType then
        do
          id = tonumber(ids[i])
          subConfig = ((TableData.gTable).BaseStoryChapterData)[id]
          if triggerType == PlotPlayTriggerType.INSTANTLY_PLAY or triggerType == PlotPlayTriggerType.BEFORE_VICTORY or subConfig.times == 0 or PlotPlayData.ForceShowPlotPlay or OvertureMgr.isPlaying then
            (PlotPlayData.Enqueue)(id)
          else
            if (PlotPlayData.PlayedPlot)[id] == nil then
              noNeedQuery = false
              ;
              (table.insert)(needQuery, id)
            else
              if (PlotPlayData.PlayedPlot)[id] == false then
                (PlotPlayData.Enqueue)(id)
              end
            end
          end
          -- DECOMPILER ERROR at PC159: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC159: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    if not noNeedQuery then
      (PlotPlayService.ReqCheckStoryFinish)(needQuery)
    end
    return noNeedQuery
  end
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

PlotPlayMgr.PlayNextPlot = function(...)
  -- function num : 0_3 , upvalues : _ENV
  if (PlotPlayData.GetNextPlot)() then
    (PlotPlayMgr.PlayPlot)()
  else
    ;
    (PlotPlayMgr.Finish)()
  end
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

PlotPlayMgr.PlayPlot = function(...)
  -- function num : 0_4 , upvalues : _ENV
  loge("Play:" .. tostring((PlotPlayData.CurrentChapterDataConfig).id))
  if (PlotPlayData.CurrentChapterDataConfig).guild_type == PlotPlayGuideType.Play or (PlotPlayData.CurrentChapterDataConfig).guild_type == PlotPlayGuideType.Both then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.PlotPlay, (PlotPlayData.CurrentChapterDataConfig).name, (PlotPlayData.CurrentChapterDataConfig).remark)
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

  PlotPlayData.DialogueAmount = 0
  ;
  (PlotPlayMgr.OpenMainUI)()
  UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_SET_BTN, (PlotPlayData.CurrentChapterDataConfig).skip)
  if (Util.StringIsNullOrEmpty)((PlotPlayData.CurrentChapterDataConfig).name) then
    UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_SET_BACKGROUND, function(...)
    -- function num : 0_4_0 , upvalues : _ENV
    UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_SHOW_ASIDE, function(...)
      -- function num : 0_4_0_0 , upvalues : _ENV
      if (TableData.GetBaseStoryDialogueData)(PlotPlayData.CurrentDialogueID) == nil then
        (PlotPlayService.ReqFinishStory)(PlotPlayFinishType.Normal, {(PlotPlayData.CurrentChapterDataConfig).id})
        ;
        (PlotPlayMgr.PlayNextPlot)()
      else
        UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_BACKGROUND_ENTER, PlotPlayMgr.PrePlayDialogueShow)
      end
    end
)
  end
)
  else
    UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_PLAY_CHAPTER_NAME, function(...)
    -- function num : 0_4_1 , upvalues : _ENV
    UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_SHOW_ASIDE, function(...)
      -- function num : 0_4_1_0 , upvalues : _ENV
      if (TableData.GetBaseStoryDialogueData)(PlotPlayData.CurrentDialogueID) == nil then
        (PlotPlayService.ReqFinishStory)(PlotPlayFinishType.Normal, {(PlotPlayData.CurrentChapterDataConfig).id})
        ;
        (PlotPlayMgr.PlayNextPlot)()
      else
        UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_BACKGROUND_ENTER, PlotPlayMgr.PrePlayDialogueShow)
      end
    end
)
  end
)
    UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_SET_BACKGROUND)
  end
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

PlotPlayMgr.PrePlayDialogueShow = function(...)
  -- function num : 0_5 , upvalues : _ENV
  local dialogueConfig = (TableData.GetBaseStoryDialogueData)(PlotPlayData.CurrentDialogueID)
  if dialogueConfig == nil then
    loge("Dialogue Id:" .. tostring(PlotPlayData.CurrentDialogueID) .. " 未在BaseStoryDialogueData中找到")
    return 
  end
  if dialogueConfig.carmera_type ~= 0 then
    UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_CAMERA_SHAKE, PlotPlayMgr.PlayDialogue)
  else
    ;
    (PlotPlayMgr.PlayDialogue)()
  end
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

PlotPlayMgr.PlayDialogue = function(id, ...)
  -- function num : 0_6 , upvalues : _ENV
  local dialogueID = nil
  if id ~= nil then
    dialogueID = id
  else
    dialogueID = PlotPlayData.CurrentDialogueID
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  PlotPlayData.DialogueAmount = PlotPlayData.DialogueAmount + 1
  UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_PLAY_DIALOGUE, {id = dialogueID})
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

PlotPlayMgr.AfterDialogueShowed = function(choice, skip, stopLine, ...)
  -- function num : 0_7 , upvalues : _ENV
  UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_STOP_SOUND, skip or stopLine)
  ;
  (PlotPlayMgr.GetToNextDialogue)(choice, skip)
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

PlotPlayMgr.GetToNextDialogue = function(choice, skip, ...)
  -- function num : 0_8 , upvalues : _ENV
  local dialogueConfig = (TableData.GetBaseStoryDialogueData)(PlotPlayData.CurrentDialogueID)
  if dialogueConfig.next == PlotPlayNextDialogueType.DONE or skip or dialogueConfig.next == PlotPlayNextDialogueType.KEEP then
    if (PlotPlayData.CurrentChapterDataConfig).guild_type == PlotPlayGuideType.Finish or (PlotPlayData.CurrentChapterDataConfig).guild_type == PlotPlayGuideType.Both then
      (Util.ShowGuideTips)(GuideTipsCheckPoint.PlotPlay, (PlotPlayData.CurrentChapterDataConfig).name, (PlotPlayData.CurrentChapterDataConfig).remark)
    end
    if skip then
      (PlotPlayService.ReqFinishStory)(PlotPlayFinishType.Skip, (PlotPlayData.GetLeftPlots)())
      ;
      (PlotPlayData.SkipToLastPlot)()
    else
      ;
      (PlotPlayService.ReqFinishStory)(PlotPlayFinishType.Normal, {(PlotPlayData.CurrentChapterDataConfig).id})
    end
    if dialogueConfig.next == PlotPlayNextDialogueType.KEEP then
      UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_CALLBACK_KEEP)
    else
      UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_FINISH, {Callback = PlotPlayMgr.PlayNextPlot, Skip = skip})
    end
  else
    if choice ~= nil then
      if choice == PlotPlayData.CurrentDialogueID then
        loge("choice repeat:" .. choice)
      end
      -- DECOMPILER ERROR at PC108: Confused about usage of register: R3 in 'UnsetPending'

      PlotPlayData.CurrentDialogueID = choice
      ;
      (PlotPlayData.MakeAChoice)(choice)
    else
      -- DECOMPILER ERROR at PC123: Confused about usage of register: R3 in 'UnsetPending'

      if dialogueConfig.next == PlotPlayNextDialogueType.NORMAL then
        PlotPlayData.CurrentDialogueID = PlotPlayData.CurrentDialogueID + 1
      else
        if tonumber(dialogueConfig.next) == PlotPlayData.CurrentDialogueID then
          loge("repeat:" .. dialogueConfig.next)
        end
        -- DECOMPILER ERROR at PC141: Confused about usage of register: R3 in 'UnsetPending'

        PlotPlayData.CurrentDialogueID = tonumber(dialogueConfig.next)
      end
    end
    if PlotPlayData.DialogueAmount % PlotPlayData.DialogueCheckPointStep == 0 then
      (PlotPlayData.RecordDialogueProgress)()
    end
    ;
    (PlotPlayMgr.PrePlayDialogueShow)()
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

PlotPlayMgr.Finish = function(...)
  -- function num : 0_9 , upvalues : _ENV
  (PlotPlayData.InitQueueData)()
  if UIMgr:IsWindowOpen((WinResConfig.PlotPlayPanelWindow).name) then
    UIMgr:CloseWindow((WinResConfig.PlotPlayPanelWindow).name, true, true)
    ;
    (PlotPlayMgr.Callback)()
  else
    ;
    (PlotPlayMgr.Callback)()
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

PlotPlayMgr.Callback = function(...)
  -- function num : 0_10 , upvalues : _callback
  local callback = _callback
  if callback then
    _callback = nil
    callback()
  end
end


