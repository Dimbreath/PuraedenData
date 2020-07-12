-- params : ...
-- function num : 0 , upvalues : _ENV
DailyDungeonData = {
trialDataTable = {}
}
-- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.InitTrialData = function(msg, ...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  DailyDungeonData.trialDataTable = msg.data
end

-- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.UpdateTrialData = function(settleTrial, ...)
  -- function num : 0_1 , upvalues : _ENV
  if settleTrial and settleTrial.trial then
    local type = (settleTrial.trial).type
    local preTrialData = (DailyDungeonData.GetTrialDataByType)(type)
    preTrialData.trial = settleTrial.trial
    preTrialData.cardInfo = settleTrial.cardInfo
  end
end

-- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.GetTrialDataByType = function(type, ...)
  -- function num : 0_2 , upvalues : _ENV
  local trialDataTable = DailyDungeonData.trialDataTable
  if trialDataTable then
    for _,v in ipairs(trialDataTable) do
      local trial = v.trial
      local cardInfo = v.cardInfo
      if type == trial.type then
        return v
      end
    end
  end
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.GetTrialConfigByType = function(type, ...)
  -- function num : 0_3 , upvalues : _ENV
  local baseTrialData = (TableData.gTable).BaseTrialData
  for _,config in pairs(baseTrialData) do
    if config.type == type then
      return (Util.Copy)(config)
    end
  end
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.GetRemainChallengeTime = function(type, ...)
  -- function num : 0_4 , upvalues : _ENV
  local trialData = (DailyDungeonData.GetTrialDataByType)(type)
  if trialData then
    return (trialData.trial).num
  end
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.GetChallengeCardInfo = function(type, ...)
  -- function num : 0_5 , upvalues : _ENV
  local trialData = (DailyDungeonData.GetTrialDataByType)(type)
  if trialData then
    return trialData.cardInfo
  end
  return {}
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.UpdateSelfCardInfo = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  local playType = (BattleData.GetPlayTypeByEmbattleType)(msg.type)
  local trialData = (DailyDungeonData.GetTrialDataByType)(playType)
  if trialData then
    trialData.cardInfo = msg.cardInfo
  end
  PrintTable(DailyDungeonData.trialDataTable, "更新后的每日副本")
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.IsTrialStageOpen = function(stageId, ...)
  -- function num : 0_7 , upvalues : _ENV
  local trialDataTable = DailyDungeonData.trialDataTable
  if trialDataTable then
    for _,v in ipairs(trialDataTable) do
      local trial = v.trial
      for _,stage in ipairs(trial.trialStage) do
        if stage.id == stageId then
          return true
        end
      end
    end
  end
  do
    return false
  end
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.IsNextStageOpen = function(stageId, ...)
  -- function num : 0_8 , upvalues : _ENV
  if stageId == nil then
    return nil
  end
  local stageConfig = ((TableData.gTable).BaseTrialStageData)[stageId]
  if stageConfig then
    local nextId = stageConfig.next
    if nextId == 0 then
      return true
    else
      return (DailyDungeonData.IsTrialStageOpen)(nextId)
    end
  end
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.IsTrialStagePass = function(stageId, ...)
  -- function num : 0_9 , upvalues : _ENV
  local trialDataTable = DailyDungeonData.trialDataTable
  if trialDataTable then
    for _,v in ipairs(trialDataTable) do
      local trial = v.trial
      for _,stage in ipairs(trial.trialStage) do
        -- DECOMPILER ERROR at PC24: Unhandled construct in 'MakeBoolean' P1

        if stage.isPass and stage.schedule < 10000 then
          do
            do return stage.id ~= stageId end
            -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  do return false end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.GetTrialStageSchedule = function(stageId, ...)
  -- function num : 0_10 , upvalues : _ENV
  local trialDataTable = DailyDungeonData.trialDataTable
  if trialDataTable then
    for _,v in ipairs(trialDataTable) do
      local trial = v.trial
      for _,stage in ipairs(trial.trialStage) do
        if stage.id == stageId then
          return stage.schedule
        end
      end
    end
  end
  do
    return 0
  end
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.GetTrialDataListByType = function(type, ...)
  -- function num : 0_11 , upvalues : _ENV
  local trialDataList = {}
  local trialStageConfigList = (DailyDungeonData.GetTrialStageConfigListByType)(type)
  for _,v in ipairs(trialStageConfigList) do
    v.isOpen = (DailyDungeonData.IsTrialStageOpen)(v.id)
    ;
    (table.insert)(trialDataList, v)
  end
  return trialDataList
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.GetTrialStageConfigListByType = function(type, ...)
  -- function num : 0_12 , upvalues : _ENV
  local trialStageConfigList = {}
  local configTable = (TableData.gTable).BaseTrialStageData
  for _,v in pairs(configTable) do
    if v.type == type then
      (table.insert)(trialStageConfigList, (Util.Copy)(v))
    end
  end
  ;
  (table.sort)(trialStageConfigList, function(a, b, ...)
    -- function num : 0_12_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return trialStageConfigList
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonData.IsCardInfoEmptyByType = function(type, ...)
  -- function num : 0_13 , upvalues : _ENV
  if not type then
    type = DailyDungeonMgr.curSelectTrialType
  end
  local cardInfo = (DailyDungeonData.GetChallengeCardInfo)(type)
  if cardInfo and #cardInfo > 0 then
    return false
  else
    return true
  end
end


