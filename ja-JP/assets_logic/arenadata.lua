-- params : ...
-- function num : 0 , upvalues : _ENV
ArenaData = {}
-- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.RefreshIntervel = 3
-- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.DefauleRivalAmount = 5
-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.TotalRivalAmount = 25
-- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.CurrentRivalData = nil
-- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.CombatRecords = {}
-- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.RankData = {}
-- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.BestRank = 0
-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.ClearCDCost = nil
-- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.NeedShowTips = false
ArenaClearCDType = {Failure = 0, Success = 1}
ArenaBattleType = {OffenceSuccess = 1, OffenceFailure = 2, DefenceSuccess = 3, DefenceFailure = 4}
ArenaRewardType = {DailyReward = 1, DailyRankRward = 2, CareerReward = 3}
ArenaRewardStatue = {Acquired = 1, NotAvailable = 2, Available = 3}
ArenaRewardOperateType = {SpecifyId = 1, All = 2}
ArenaReqBattleDataType = {Replay = 1, Data = 2}
ArenaRefreshDataType = {OpenUI = 1, CountDown = 2, Challenge = 3, Smash = 4, Rank = 5}
-- DECOMPILER ERROR at PC59: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.BaseData = {}
-- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.CurrentCD = 0
-- DECOMPILER ERROR at PC63: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.RewardSeason = 0
-- DECOMPILER ERROR at PC66: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.DailyRewardData = {}
-- DECOMPILER ERROR at PC69: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.CareerRewardData = {}
-- DECOMPILER ERROR at PC72: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.DailyRankRewardData = {}
-- DECOMPILER ERROR at PC75: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.AcquiredReward = {}
-- DECOMPILER ERROR at PC77: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.HaveAvaiableCareerReward = false
-- DECOMPILER ERROR at PC79: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.HaveAvailableDailyReward = false
-- DECOMPILER ERROR at PC81: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.LastReqBattleDataType = nil
-- DECOMPILER ERROR at PC83: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.LastEnterArenaTimestamp = 0
-- DECOMPILER ERROR at PC85: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.LastReqTimestamp = 0
-- DECOMPILER ERROR at PC89: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.LastReqOp = ArenaRefreshDataType.OpenUI
-- DECOMPILER ERROR at PC91: Confused about usage of register: R0 in 'UnsetPending'

ArenaData.AfterOpenCallback = nil
local _successCD = 0
local _failureCD = 0
local _currentRivalIndex = 0
local _battleData = {}
-- DECOMPILER ERROR at PC98: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.InitData = function(...)
  -- function num : 0_0 , upvalues : _ENV, _failureCD, _successCD
  for k,v in pairs((TableData.gTable).BasePlayData) do
    if v.type == PlayType.Arena then
      local cds = split(v.cd, ",")
      local count = #cds
      local item = nil
      for i = 1, count do
        item = split(cds[i], ":")
        if tonumber(item[1]) == ArenaClearCDType.Failure then
          _failureCD = tonumber(item[2])
        else
          if tonumber(item[1]) == ArenaClearCDType.Success then
            _successCD = tonumber(item[2])
          end
        end
      end
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R8 in 'UnsetPending'

      ArenaData.ClearCDCost = v.cd_cost
      break
    end
  end
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.SetCurrentCD = function(...)
  -- function num : 0_1 , upvalues : _ENV, _successCD, _failureCD
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  if (ArenaData.BaseData).lastSuccess then
    ArenaData.CurrentCD = _successCD
  else
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ArenaData.CurrentCD = _failureCD
  end
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.CheckSettle = function(...)
  -- function num : 0_2 , upvalues : _ENV
  local current = (LuaTime.GetTimeStamp)() * 1000
  do return ((ArenaData.BaseData).settleTime).bTime <= current and current < ((ArenaData.BaseData).settleTime).bTime + ((ArenaData.BaseData).settleTime).durationTime end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.CheckOpen = function(...)
  -- function num : 0_3 , upvalues : _ENV
  local current = (LuaTime.GetTimeStamp)() * 1000
  do return ((ArenaData.BaseData).openTime).bTime <= current and current < ((ArenaData.BaseData).openTime).bTime + ((ArenaData.BaseData).openTime).durationTime end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.CheckDayPass = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local current = (LuaTime.GetTimeStamp)() * 1000
  do return ((ArenaData.BaseData).openTime).bTime + ((ArenaData.BaseData).openTime).durationTime <= current end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.CheckCD = function(...)
  -- function num : 0_5 , upvalues : _ENV
  do return (ArenaData.GetCurrentCD)() > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.GetCurrentCD = function(...)
  -- function num : 0_6 , upvalues : _ENV
  local cd = (ArenaData.BaseData).lastArenaFightTime * 0.001 + ArenaData.CurrentCD - (LuaTime.GetTimeStamp)()
  if cd < 0 then
    cd = 0
  end
  return cd
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.InitRewardData = function(...)
  -- function num : 0_7 , upvalues : _ENV
  if #ArenaData.DailyRewardData ~= 0 and (ArenaData.BaseData).season == ArenaData.RewardSeason then
    return 
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ArenaData.DailyRewardData = {}
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

  ArenaData.DailyRankRewardData = {}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ArenaData.CareerRewardData = {}
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

  ArenaData.RewardSeason = (ArenaData.BaseData).season
  for k,v in pairs((TableData.gTable).BaseArenaRewardData) do
    if v.type == ArenaRewardType.DailyReward then
      (table.insert)(ArenaData.DailyRewardData, v)
    else
      if v.type == ArenaRewardType.DailyRankRward then
        (table.insert)(ArenaData.DailyRankRewardData, v)
      else
        if v.type == ArenaRewardType.CareerReward and v.phase == (ArenaData.BaseData).season then
          (table.insert)(ArenaData.CareerRewardData, v)
        end
      end
    end
  end
  ;
  (ArenaData.SortRewardData)()
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.InitRewardsStatue = function(...)
  -- function num : 0_8 , upvalues : _ENV
  local count = #(ArenaData.BaseData).monthRewards
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ArenaData.AcquiredReward = {}
  for i = 1, count do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

    (ArenaData.AcquiredReward)[((ArenaData.BaseData).monthRewards)[i]] = true
  end
  count = #(ArenaData.BaseData).dayRewards
  for i = 1, count do
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

    (ArenaData.AcquiredReward)[((ArenaData.BaseData).dayRewards)[i]] = true
  end
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.SortRewardData = function(...)
  -- function num : 0_9 , upvalues : _ENV
  (table.sort)(ArenaData.DailyRewardData, function(x, y, ...)
    -- function num : 0_9_0 , upvalues : _ENV
    local xWeight = (ArenaData.GetDailyRewardStatue)(x) * 10000
    local yWeight = (ArenaData.GetDailyRewardStatue)(y) * 10000
    xWeight = xWeight - x.sort
    yWeight = yWeight - y.sort
    do return yWeight < xWeight end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(ArenaData.DailyRankRewardData, function(x, y, ...)
    -- function num : 0_9_1
    do return x.sort < y.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(ArenaData.CareerRewardData, function(x, y, ...)
    -- function num : 0_9_2 , upvalues : _ENV
    local xWeight = (ArenaData.GetCareerRewardStatue)(x) * 10000
    local yWeight = (ArenaData.GetCareerRewardStatue)(y) * 10000
    xWeight = xWeight - x.sort
    yWeight = yWeight - y.sort
    do return yWeight < xWeight end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.GetDailyRewardStatue = function(config, ...)
  -- function num : 0_10 , upvalues : _ENV
  if (ArenaData.AcquiredReward)[config.id] ~= nil then
    return ArenaRewardStatue.Acquired
  else
    if config.rank_low <= (ArenaData.BaseData).score then
      return ArenaRewardStatue.Available
    else
      return ArenaRewardStatue.NotAvailable
    end
  end
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.GetCareerRewardStatue = function(config, ...)
  -- function num : 0_11 , upvalues : _ENV
  if (ArenaData.AcquiredReward)[config.id] ~= nil then
    return ArenaRewardStatue.Acquired
  else
    if (ArenaData.BaseData).seasonMaxRank <= config.rank_low and (ArenaData.BaseData).seasonMaxRank ~= 0 then
      return ArenaRewardStatue.Available
    else
      return ArenaRewardStatue.NotAvailable
    end
  end
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.CovertArenaRivalFormationToLocalPlayer = function(arenaRivalCards, power, ...)
  -- function num : 0_12 , upvalues : _ENV
  local formation = {}
  local count = #arenaRivalCards
  for i = 1, count do
    formation[(arenaRivalCards[i]).position] = {}
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (formation[(arenaRivalCards[i]).position]).fashionId = ((CardData.GetFashionConfig)(arenaRivalCards[i])).id
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (formation[(arenaRivalCards[i]).position]).spd = (arenaRivalCards[i]).speed
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R8 in 'UnsetPending'

    if i == 1 then
      (formation[(arenaRivalCards[i]).position]).fc = power
    else
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (formation[(arenaRivalCards[i]).position]).fc = 0
    end
  end
  return formation
end

-- DECOMPILER ERROR at PC137: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.CovertArenaRivalFormationToLocal = function(arenaRivalCards, ...)
  -- function num : 0_13
  local formation = {}
  local count = #arenaRivalCards
  for i = 1, count do
    formation[(arenaRivalCards[i]).position] = (arenaRivalCards[i]).id
  end
  return formation
end

-- DECOMPILER ERROR at PC140: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.UpdateBattleData = function(data, ...)
  -- function num : 0_14 , upvalues : _battleData
  _battleData[(data.battleData).battleUid] = data
end

-- DECOMPILER ERROR at PC143: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.GetBattleData = function(id, ...)
  -- function num : 0_15 , upvalues : _battleData
  return _battleData[id]
end

-- DECOMPILER ERROR at PC146: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.SaveFightResult = function(fightResult, ...)
  -- function num : 0_16 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  ArenaData.fightResult = fightResult
end

-- DECOMPILER ERROR at PC149: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.GetFightResult = function(...)
  -- function num : 0_17 , upvalues : _ENV
  return ArenaData.fightResult
end

-- DECOMPILER ERROR at PC152: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.GetFC = function(info, ...)
  -- function num : 0_18 , upvalues : _ENV
  if info.isPlayer then
    return info.fc
  else
    local fc = 0
    local config = nil
    if info.battleindex == nil then
      local count = #info.cardGroups
      for i = 1, count do
        config = (TableData.GetBaseMonsterData)(tonumber(((info.cardGroups)[i]).id))
        if config then
          fc = fc + config.fc
        end
      end
      return (math.ceil)((fc) * info.fc * 0.0001)
    else
      do
        local count = #((info.cardGroups)[1]).teamCard
        for i = 1, count do
          config = (TableData.GetBaseMonsterData)(tonumber((((((info.cardGroups)[1]).teamCard)[i]).cardInfo).id))
          if config then
            fc = fc + config.fc
          end
        end
        do return (math.ceil)((fc) * info.fc * 0.0001) end
      end
    end
  end
end

-- DECOMPILER ERROR at PC155: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.CheckCareerRewardRedDot = function(...)
  -- function num : 0_19 , upvalues : _ENV
  local CanGet = false
  for _,v in pairs(ArenaData.CareerRewardData) do
    local statue = (ArenaData.GetCareerRewardStatue)(v)
    if statue == ArenaRewardStatue.Available then
      CanGet = true
      break
    end
  end
  do
    if not CanGet then
      (RedDotMgr.EliminateRedDot)((WinResConfig.ArenaRewardWindow).name, RedDotComID.ArenaReward_Career)
    end
  end
end

-- DECOMPILER ERROR at PC158: Confused about usage of register: R4 in 'UnsetPending'

ArenaData.CheckDailyRewardRedDot = function(...)
  -- function num : 0_20 , upvalues : _ENV
  local CanGet = false
  for _,v in pairs(ArenaData.DailyRewardData) do
    local statue = (ArenaData.GetDailyRewardStatue)(v)
    if statue == ArenaRewardStatue.Available then
      CanGet = true
      break
    end
  end
  do
    if not CanGet then
      (RedDotMgr.EliminateRedDot)((WinResConfig.ArenaRewardWindow).name, RedDotComID.ArenaReward_Integer)
    end
  end
end

;
(ArenaData.InitData)()

