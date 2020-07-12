-- params : ...
-- function num : 0 , upvalues : _ENV
PlotPlayData = {}
PlotPlayDialogueType = {LEFT = 1, RIGHT = 2}
PlotPlayNextDialogueType = {DONE = -1, NORMAL = 0, KEEP = 1}
PlotPlayTriggerLimit = {NO_LIMIT = 0, ONCE = 1}
PlotPlayCameraEffect = {Horizontal = 1, Vertical = 2, Multiply = 3}
PlotPlayBGEffect = {None = 0, LinearMove = 1, Rotate = 2, Zoom = 3, Fade = 4, Effect = 5, WhiteScreen = 6}
PlotPlayBGDirection = {LeftToRight = 1, TopToBottom = 2, LeftTopToRightBottom = 3, NoDirection = 4}
PlotPlayTriggerCameraType = {BeforeLinesShow = 1, AfterLinesShowed = 2}
PlotPlayBtnStatus = {Disable = 0, Enable = 1, Hide = 2}
PlotPlayFinishType = {Normal = 1, Skip = 2}
PlotPlayRoleExpType = {Partial = 0, All = 1}
PlotPlayGuideType = {NoTips = 0, Play = 1, Finish = 2, Both = 3}
PlotRoleSpecialInOutType = {Normal = 0, Special1 = 1, Special2 = 2}
PlotPlayDisableMotionRole = {}
-- DECOMPILER ERROR at PC67: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.CurrentChapterDataConfig = {}
-- DECOMPILER ERROR at PC69: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.NotShowSwitchBtn = false
-- DECOMPILER ERROR at PC71: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.FirstDialogueID = 0
-- DECOMPILER ERROR at PC73: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.LastDialogueID = 0
-- DECOMPILER ERROR at PC75: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.CurrentDialogueID = 0
-- DECOMPILER ERROR at PC77: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.DialogueCheckPointStep = 0
-- DECOMPILER ERROR at PC79: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.AutoPlayInterval = 1
-- DECOMPILER ERROR at PC81: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.DialogueAmount = 0
-- DECOMPILER ERROR at PC84: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.PlotQueue = {}
-- DECOMPILER ERROR at PC86: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.CurrentPlotIndex = 0
-- DECOMPILER ERROR at PC89: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.PlayedPlot = {}
-- DECOMPILER ERROR at PC91: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.ForceShowPlotPlay = false
-- DECOMPILER ERROR at PC93: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.ForceKeepBGM = false
-- DECOMPILER ERROR at PC95: Confused about usage of register: R0 in 'UnsetPending'

PlotPlayData.DefaultMotion = "idle"
local _dialogueProgress = {}
local _choices = {}
local _plotQueue = {}
local _currentPlotIndex = 0
-- DECOMPILER ERROR at PC102: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.InitData = function(...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  if PlotPlayData.DialogueCheckPointStep == 0 then
    PlotPlayData.DialogueCheckPointStep = (((TableData.gTable).BaseFixedData)[72010001]).int_value
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

    PlotPlayData.AutoPlayInterval = (((TableData.gTable).BaseFixedData)[72010002]).int_value
  end
end

-- DECOMPILER ERROR at PC105: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.InitQueueData = function(...)
  -- function num : 0_1 , upvalues : _plotQueue, _currentPlotIndex
  _plotQueue = {}
  _currentPlotIndex = 0
end

-- DECOMPILER ERROR at PC108: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.GetLeftPlots = function(...)
  -- function num : 0_2 , upvalues : _plotQueue, _currentPlotIndex
  local plots = {}
  local count = #_plotQueue
  for i = _currentPlotIndex, count do
    plots[#plots + 1] = _plotQueue[i]
  end
  return plots
end

-- DECOMPILER ERROR at PC111: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.Enqueue = function(id, ...)
  -- function num : 0_3 , upvalues : _ENV, _plotQueue
  (table.insert)(_plotQueue, id)
end

-- DECOMPILER ERROR at PC114: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.HaveNextPlot = function(...)
  -- function num : 0_4 , upvalues : _plotQueue, _currentPlotIndex
  if _plotQueue[_currentPlotIndex + 1] == nil then
    return false
  else
    return true
  end
end

-- DECOMPILER ERROR at PC117: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.GetNextPlot = function(...)
  -- function num : 0_5 , upvalues : _currentPlotIndex, _plotQueue, _ENV
  _currentPlotIndex = _currentPlotIndex + 1
  if _plotQueue[_currentPlotIndex] == nil then
    return false
  else
    return (PlotPlayData.InitDataById)(_plotQueue[_currentPlotIndex])
  end
end

-- DECOMPILER ERROR at PC120: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.CheckNextPlotBGM = function(bgm, ...)
  -- function num : 0_6 , upvalues : _ENV, _currentPlotIndex, _plotQueue
  if PlotPlayData.ForceKeepBGM then
    return false
  end
  local index = _currentPlotIndex + 1
  local id = _plotQueue[index]
  if id == nil then
    return true
  else
    local config = ((TableData.gTable).BaseStoryChapterData)[id]
    if config == nil then
      return true
    end
    local dialogueId = tonumber(config.dialogue_ids)
    local dialogueConfig = (TableData.GetBaseStoryDialogueData)(dialogueId)
    return dialogueConfig.bgm ~= bgm
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC123: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.SkipToLastPlot = function(...)
  -- function num : 0_7 , upvalues : _currentPlotIndex, _plotQueue, _ENV
  if _currentPlotIndex == #_plotQueue then
    return 
  end
  _currentPlotIndex = #_plotQueue
  ;
  (PlotPlayData.InitDataById)(_plotQueue[_currentPlotIndex])
end

-- DECOMPILER ERROR at PC126: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.GetRoleEffects = function(str, ...)
  -- function num : 0_8 , upvalues : _ENV
  if (Util.StringIsNullOrEmpty)(str) == false and str ~= "0" then
    local result = {}
    local effects = split(str, ",")
    local count = #effects
    local item, roleId = nil, nil
    local left = {}
    local right = {}
    for i = 1, count do
      item = split(effects[i], ":")
      roleId = tonumber(item[1])
      result[roleId] = {Index = i, X = tonumber(item[2]), Y = tonumber(item[3]), WithoutAlpha = item[5] ~= nil and tonumber(item[5]) == 1}
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R12 in 'UnsetPending'

      if item[4] == nil then
        (result[roleId]).Special = 0
      else
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R12 in 'UnsetPending'

        (result[roleId]).Special = tonumber(item[4])
      end
    end
    return result
  else
    return {}
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC129: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.GetRoleEffectDelay = function(enter, info, info2, ...)
  -- function num : 0_9 , upvalues : _ENV
  local delay = {}
  local left = {}
  local right = {}
  if (_G.next)(info2) == nil then
    return delay
  end
  if enter then
    for k,v in pairs(info) do
      if info2[v.Index] ~= nil then
        if v.X > 0 then
          (table.insert)(left, {Id = k, X = tonumber((split(info2[v.Index], ":"))[1])})
        else
          if v.X < 0 then
            (table.insert)(right, {Id = k, X = tonumber((split(info2[v.Index], ":"))[1])})
          end
        end
      end
    end
    ;
    (table.sort)(left, function(x, y, ...)
    -- function num : 0_9_0
    if x.X == y.X then
      return false
    else
      return y.X < x.X
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
    ;
    (table.sort)(right, function(x, y, ...)
    -- function num : 0_9_1
    if x.X == y.X then
      return false
    else
      return x.X < y.X
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  else
    for k,v in pairs(info) do
      if info2[k] ~= nil then
        if v.X > 0 then
          (table.insert)(right, {Id = k, X = ((((info2[k]).Info).Loader).parent).x})
        else
          if v.X < 0 then
            (table.insert)(left, {Id = k, X = ((((info2[k]).Info).Loader).parent).x})
          end
        end
      end
    end
    ;
    (table.sort)(right, function(x, y, ...)
    -- function num : 0_9_2
    if x.X == y.X then
      return false
    else
      return y.X < x.X
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
    ;
    (table.sort)(left, function(x, y, ...)
    -- function num : 0_9_3
    if x.X == y.X then
      return false
    else
      return x.X < y.X
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  end
  local count = #left
  for i = 1, count do
    delay[(left[i]).Id] = i - 1
  end
  count = #right
  for i = 1, count do
    delay[(right[i]).Id] = i - 1
  end
  return delay
end

-- DECOMPILER ERROR at PC132: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.InitDataById = function(id, ...)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  PlotPlayData.CurrentChapterDataConfig = ((TableData.gTable).BaseStoryChapterData)[id]
  if PlotPlayData.CurrentChapterDataConfig == nil then
    logw("剧情:" .. id .. "未配置")
    ;
    (PlotPlayMgr.PlayNextPlot)()
    return false
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  PlotPlayData.FirstDialogueID = tonumber((PlotPlayData.CurrentChapterDataConfig).dialogue_ids)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  PlotPlayData.CurrentDialogueID = PlotPlayData.FirstDialogueID
  return true
end

-- DECOMPILER ERROR at PC135: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.GetDialogueProgress = function(chapterID, ...)
  -- function num : 0_11 , upvalues : _dialogueProgress, _ENV, _choices
  if _dialogueProgress[chapterID] == nil then
    return PlotPlayData.FirstDialogueID
  else
    local config = nil
    local dialogueId = PlotPlayData.FirstDialogueID
    local dialogueCount = 0
    local checkpointCount = 0
    local choiceIndex = 0
    while 1 do
      while 1 do
        while 1 do
          while 1 do
            config = (TableData.GetBaseStoryDialogueData)(dialogueId)
            if config.next ~= PlotPlayNextDialogueType.DONE and config.next ~= PlotPlayNextDialogueType.KEEP then
              dialogueCount = dialogueCount + 1
              -- DECOMPILER ERROR at PC37: Unhandled construct in 'MakeBoolean' P1

              if (dialogueCount) % PlotPlayData.DialogueCheckPointStep == 1 and _dialogueProgress[chapterID] > checkpointCount then
                checkpointCount = checkpointCount + 1
                if config.option_ids == "0" or config.option_ids == nil then
                  if config.next == PlotPlayNextDialogueType.NORMAL then
                    dialogueId = dialogueId + 1
                    -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          end
          dialogueId = config.next
        end
        choiceIndex = choiceIndex + 1
        if _choices[chapterID] ~= nil and (_choices[chapterID])[choiceIndex] ~= nil then
          dialogueId = (_choices[chapterID])[choiceIndex]
          -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
      local options = split(config.option_ids)
      dialogueId = (((TableData.gTable).BaseStoryOptionData)[tonumber(options[1])]).next
    end
    do
      do return dialogueId end
    end
  end
end

-- DECOMPILER ERROR at PC138: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.GetCurrentDialogues = function(...)
  -- function num : 0_12 , upvalues : _plotQueue, _ENV, _choices
  local dialogues = {}
  local dialogueConfig, optionConfig, index, choiceIndex = nil, nil, nil, nil
  local count = #_plotQueue
  local chapterId = nil
  for i = 1, count do
    chapterId = _plotQueue[i]
    index = tonumber((((TableData.gTable).BaseStoryChapterData)[chapterId]).dialogue_ids)
    choiceIndex = 0
    while 1 do
      while 1 do
        while 1 do
          while 1 do
            dialogueConfig = (TableData.GetBaseStoryDialogueData)(index)
            if dialogueConfig ~= nil then
              (table.insert)(dialogues, dialogueConfig.id)
              if PlotPlayData.CurrentDialogueID == dialogueConfig.id then
                i = count + 1
                -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
          -- DECOMPILER ERROR at PC60: Unhandled construct in 'MakeBoolean' P1

          if (dialogueConfig.option_ids == "0" or dialogueConfig.option_ids == nil) and dialogueConfig.next ~= PlotPlayNextDialogueType.DONE and dialogueConfig.next ~= PlotPlayNextDialogueType.KEEP then
            if dialogueConfig.next == PlotPlayNextDialogueType.NORMAL then
              index = index + 1
              -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
        index = dialogueConfig.next
      end
      choiceIndex = choiceIndex + 1
      index = (_choices[chapterId])[choiceIndex]
    end
  end
  do
    if i ~= count + 1 then
      return dialogues
    end
  end
end

-- DECOMPILER ERROR at PC141: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.RecordDialogueProgress = function(id, ...)
  -- function num : 0_13 , upvalues : _ENV, _dialogueProgress
  local chapterID = nil
  if id ~= nil then
    chapterID = id
  else
    chapterID = (PlotPlayData.CurrentChapterDataConfig).id
  end
  if _dialogueProgress[chapterID] == nil then
    _dialogueProgress[chapterID] = 1
  else
    _dialogueProgress[chapterID] = _dialogueProgress[chapterID] + 1
  end
end

-- DECOMPILER ERROR at PC144: Confused about usage of register: R4 in 'UnsetPending'

PlotPlayData.MakeAChoice = function(choice, id, ...)
  -- function num : 0_14 , upvalues : _ENV, _choices
  local chapterID = nil
  if id ~= nil then
    chapterID = id
  else
    chapterID = (PlotPlayData.CurrentChapterDataConfig).id
  end
  if _choices[chapterID] == nil then
    _choices[chapterID] = {}
  end
  ;
  (table.insert)(_choices[chapterID], choice)
end


