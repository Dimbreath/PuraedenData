-- params : ...
-- function num : 0 , upvalues : _ENV
AdventureData = {}
-- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.MULTI_DICE_NUMBER = 10
-- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.MAX_CHOOSE_EVENT = 6
-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.MAX_DICE_NUMBER = 6
-- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.MAX_GUARD_AMOUNT = 3
-- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.MAX_WISH_REWARD = 6
-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.TAROT_CARD_AMOUNT = 4
-- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.FIXED_MOVE_TIMES = 2
-- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.MAX_TAROT_RESULT = 5
AdventureInitType = {OpenUI = 1, Refresh = 2, OpenSubFunc = 3}
AdventureDiceType = {Single = 1, Multiply = 2, Remote = 3}
AdventureWishRewardType = {Tarot = 1, Adventure = 2}
AdventureBuildingOperateType = {RequestInfo = 1, RequestReward = 2, DeployCard = 3, Unlock = 4}
AdventureDeployType = {Deploy = 1, Recall = 2}
AdventureNodeType = {Begin = 0, End = 1, Normal = 2, ForkBegin = 3, ForkEnd = 4}
AdventureEventType = {None = 0, Gold = 1, Diamond = 2, Reward = 3, Building = 4, RPS = 10, Question = 11, Brick = 12, Goldmine = 13, Battle = 14}
-- DECOMPILER ERROR at PC69: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.BRICK_ICON_INDEX = {Start = 0, Gold = 1, GoldTaken = 2, Building = 3, Event = 4, Diamond = 5}
-- DECOMPILER ERROR at PC78: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.EVENT_ICON_INDEX = {Answer = 0, Battle = 1, Brick = 3, Building = 6, Mining = 4, Rock_Paper_Scissors = 2}
-- DECOMPILER ERROR at PC85: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.MULTIPLE_MARK_INDEX = {[0] = 0, [2] = 1, [3] = 2, [5] = 3}
AdventureWishType = {Tarot = 1, Wish = 2}
AdventureTarotStatue = {Available = 1, NotOpen = 2, Played = 3}
AdventureRewardType = {Wish = -1, Basic = 0, Win = 10, Lose = 11, Even = 12, Right0 = 20, Right1 = 21, Right2 = 22, Right3 = 23, Right4 = 24, RightAll = 25, Brick = 30, Miner = 31}
AdventureRPSGestureType = {Rock = 0, Scissor = 1, Paper = 2}
-- DECOMPILER ERROR at PC117: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.MiniGameRewards = {}
-- DECOMPILER ERROR at PC119: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.CurrentMapConfig = nil
-- DECOMPILER ERROR at PC121: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.CurrentNode = nil
-- DECOMPILER ERROR at PC123: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.WishPoint = 0
-- DECOMPILER ERROR at PC125: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.PlayWishPointAnim = false
-- DECOMPILER ERROR at PC127: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.StepToTarot = 0
-- DECOMPILER ERROR at PC129: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.WishAvailable = false
-- DECOMPILER ERROR at PC133: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.TarotStatue = AdventureTarotStatue.NotOpen
-- DECOMPILER ERROR at PC135: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.TarotResult = 0
-- DECOMPILER ERROR at PC138: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.TarotResultInfo = {}
-- DECOMPILER ERROR at PC140: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.TriggeredTarot = 0
-- DECOMPILER ERROR at PC143: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.UndoneEvent = {}
-- DECOMPILER ERROR at PC146: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.Buildings = {}
-- DECOMPILER ERROR at PC149: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.BuildingInfo = {}
-- DECOMPILER ERROR at PC152: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.PassedNode = {}
-- DECOMPILER ERROR at PC154: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.CurrentMoveNode = 0
-- DECOMPILER ERROR at PC156: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.TargetNode = nil
-- DECOMPILER ERROR at PC158: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.TargetMap = nil
-- DECOMPILER ERROR at PC160: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.NeedChoose = false
-- DECOMPILER ERROR at PC162: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.LeftStep = 0
-- DECOMPILER ERROR at PC165: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.EventPoint = {}
-- DECOMPILER ERROR at PC168: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.ChosedEvent = {}
-- DECOMPILER ERROR at PC170: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.ChosedEventAmount = 0
-- DECOMPILER ERROR at PC173: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.ChosedEventCost = {}
-- DECOMPILER ERROR at PC176: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.Rewards = {}
-- DECOMPILER ERROR at PC179: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.TirggeredEvent = {}
-- DECOMPILER ERROR at PC182: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.PassingNode = {}
-- DECOMPILER ERROR at PC184: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.FCEnhanceEffect = nil
-- DECOMPILER ERROR at PC187: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.AvailableCards = {}
-- DECOMPILER ERROR at PC189: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.Initialized = false
-- DECOMPILER ERROR at PC191: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.BoughtCtrlDice = 0
-- DECOMPILER ERROR at PC193: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.CtrlDiceCost = nil
-- DECOMPILER ERROR at PC196: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.AllWishRewards = {}
-- DECOMPILER ERROR at PC199: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.WishRewards = {}
-- DECOMPILER ERROR at PC201: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.DealingEvent = nil
-- DECOMPILER ERROR at PC203: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.MiniGameRewardID = 0
-- DECOMPILER ERROR at PC205: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.DailyWishPointUpperLimit = 0
-- DECOMPILER ERROR at PC207: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.StepToGetWishPoint = 0
-- DECOMPILER ERROR at PC209: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.OpeningBuildingUI = false
-- DECOMPILER ERROR at PC211: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.ChosedFork = 0
-- DECOMPILER ERROR at PC213: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.DailyTarotLimit = 0
-- DECOMPILER ERROR at PC215: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.TarotNeedStep = 0
-- DECOMPILER ERROR at PC217: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.MaxWishTimes = 0
-- DECOMPILER ERROR at PC220: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.WishPointCheckPoint = {}
-- DECOMPILER ERROR at PC222: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.BattleNode = 0
-- DECOMPILER ERROR at PC225: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.BattleFormation = {}
-- DECOMPILER ERROR at PC228: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.TarotRewards = {}
-- DECOMPILER ERROR at PC230: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.NeedShowResult = false
-- DECOMPILER ERROR at PC232: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.BulletLineGap = 5
-- DECOMPILER ERROR at PC234: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.BulletBaseSpeed = 0.02
-- DECOMPILER ERROR at PC237: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.TaroChatData = {}
-- DECOMPILER ERROR at PC240: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.CurrentBulletStatue = {}
-- DECOMPILER ERROR at PC242: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.MaxBulletAmount = 0
-- DECOMPILER ERROR at PC245: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.BulletsSizePool = {}
-- DECOMPILER ERROR at PC248: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.BulletsSpeedPool = {}
-- DECOMPILER ERROR at PC251: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.BulletsColorPool = {}
-- DECOMPILER ERROR at PC253: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.BulletComponent = "TaroWord"
-- DECOMPILER ERROR at PC255: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.FirstGetBuildingInfoDaily = false
-- DECOMPILER ERROR at PC259: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.InitOperate = AdventureInitType.OpenUI
-- DECOMPILER ERROR at PC261: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.AfterInitCallback = nil
-- DECOMPILER ERROR at PC264: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.ResetChosedEvent = function(...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  AdventureData.ChosedEvent = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  AdventureData.ChosedEventAmount = 0
  if (_G.next)(AdventureData.ChosedEventCost) == nil then
    (AdventureData.InitEventCostData)()
  end
end

-- DECOMPILER ERROR at PC267: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.InitEventCostData = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local allData = (MessageMgr.GetBuyTimesInfo)()
  local costs = (allData[BuyTimesType.AdventureGameEvent]).Costs
  local count = #costs
  local cost = nil
  for i = 1, count do
    cost = costs[i]
    for j = cost.Floor, cost.Ceil do
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R12 in 'UnsetPending'

      (AdventureData.ChosedEventCost)[j] = cost.Cost
    end
  end
end

-- DECOMPILER ERROR at PC270: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetCtrlDiceCost = function(...)
  -- function num : 0_2 , upvalues : _ENV
  local costs = ((MessageMgr.GetBuyTimesInfo)())[BuyTimesType.AdventureGameCtrlDice]
  local count = #costs.Costs
  local times = AdventureData.BoughtCtrlDice + 1
  for k,v in pairs(costs.Costs) do
    if v.Floor <= times and times <= v.Ceil then
      return v.Cost
    end
  end
  if costs.HaveLimits then
    return nil
  else
    return ((costs.Costs)[#costs.Costs]).Cost
  end
end

-- DECOMPILER ERROR at PC273: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.ResetData = function(...)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  AdventureData.Initialized = false
end

-- DECOMPILER ERROR at PC276: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.InitData = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.Initialized = true
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.CurrentMapConfig = ((TableData.gTable).BaseAdventureMapData)[msg.mapId]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.CurrentNode = msg.nodeId
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.UndoneEvent = msg.undoneEvent
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.BoughtCtrlDice = msg.boughtCtrlDice
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.WishPoint = msg.wishPoint
  if AdventureData.TarotNeedStep == 0 then
    local args = split((((TableData.gTable).BaseFixedData)[Const.DAILY_WISH_LIMIT]).array_value, ":")
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

    AdventureData.DailyTarotLimit = tonumber(args[1])
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

    AdventureData.TarotNeedStep = tonumber(args[2])
    args = split((((TableData.gTable).BaseFixedData)[Const.WISH_CHECKPOINT]).array_value, ":")
    local count = #args
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R3 in 'UnsetPending'

    AdventureData.WishPointCheckPoint = {}
    for i = 1, count do
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R7 in 'UnsetPending'

      (AdventureData.WishPointCheckPoint)[i] = tonumber(args[i])
    end
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R3 in 'UnsetPending'

    AdventureData.MaxWishTimes = (AdventureData.WishPointCheckPoint)[count]
  end
  do
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.StepToTarot = AdventureData.TarotNeedStep - msg.stepToTarot
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.WishAvailable = msg.isWish
    -- DECOMPILER ERROR at PC87: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.TarotStatue = msg.isTarot
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.TriggeredTarot = msg.triggeredTarot
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.TarotResult = (AdventureData.GetTarotResultInfo)(msg.tarotId)
    if AdventureData.TarotStatue == AdventureTarotStatue.Played then
      (AdventureData.SetTarotResultList)()
    end
    ;
    (AdventureData.InitBuildingInfo)(msg.buildings)
    ;
    (AdventureData.InitPassedNodeInfo)(msg.passedNode)
  end
end

-- DECOMPILER ERROR at PC279: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.InitBuildingInfo = function(buildings, ...)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.BuildingInfo = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.AvailableCards = {}
  local allCards = (CardData.GetObtainedCardList)()
  local usedCards = {}
  local count = #buildings
  local data, subCount, totalOutput, upperOutput = nil, nil, nil, nil
  for i = 1, count do
    data = buildings[i]
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (AdventureData.BuildingInfo)[data.buildingId] = data
    subCount = #data.cardIndex
    for j = 1, subCount do
      usedCards[((data.cardIndex)[j]).id] = true
    end
    data.totalOutput = (AdventureData.UnifyBuildingOutput)(data.totalOutput)
    data.upperOutput = (AdventureData.UnifyBuildingOutput)(data.upperOutput)
  end
  count = #allCards
  for i = 1, count do
    data = allCards[i]
    if usedCards[data.id] == nil then
      (table.insert)(AdventureData.AvailableCards, data.id)
    end
  end
  ;
  (table.sort)(AdventureData.AvailableCards, function(x, y, ...)
    -- function num : 0_5_0 , upvalues : _ENV
    local xData = (CardData.GetCardData)(x)
    local yData = (CardData.GetCardData)(y)
    do return yData.fc < xData.fc end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC282: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.InitAllBuildings = function(...)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  AdventureData.Buildings = {}
  for k,v in pairs((TableData.gTable).BaseAdventureBuildingData) do
    (table.insert)(AdventureData.Buildings, v.id)
  end
end

-- DECOMPILER ERROR at PC285: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.UnifyBuildingOutput = function(output, ...)
  -- function num : 0_7 , upvalues : _ENV
  local unifiedDic = {}
  local unifiedOutput = {}
  local count = #output
  local data = nil
  for i = 1, count do
    data = output[i]
    if unifiedDic[data.id] == nil then
      unifiedDic[data.id] = {id = data.id, type = data.type, value = 0}
    end
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (unifiedDic[data.id]).value = (unifiedDic[data.id]).value + data.value
  end
  for k,v in pairs(unifiedDic) do
    (table.insert)(unifiedOutput, v)
  end
  return unifiedOutput
end

-- DECOMPILER ERROR at PC288: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.InitPassedNodeInfo = function(passedNode, ...)
  -- function num : 0_8 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.PassedNode = {}
  local count = #passedNode
  for i = 1, count do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

    (AdventureData.PassedNode)[passedNode[i]] = true
  end
end

-- DECOMPILER ERROR at PC291: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetNextPotentialEvents = function(beginNode, ...)
  -- function num : 0_9 , upvalues : _ENV
  local events = {}
  local node = beginNode
  local config = ((TableData.gTable).BaseAdventureNodeData)[node]
  local eventConfig = nil
  local step = 0
  local leftEndurance = (ActorData.GetAssetCount)(AssetType.ENDURANCE)
  while 1 do
    if config.type ~= AdventureNodeType.End then
      step = step + 1
      if AdventureData.MAX_DICE_NUMBER < step then
        step = 1
        leftEndurance = leftEndurance - 1
      end
    end
    if leftEndurance > 0 then
      if config.type == AdventureNodeType.ForkBegin then
        local nexts = split(config.next, ":")
        config = ((TableData.gTable).BaseAdventureNodeData)[tonumber(nexts[config.index])]
      else
        do
          config = ((TableData.gTable).BaseAdventureNodeData)[tonumber(config.next)]
          node = config.id
          if config.event_id ~= 0 then
            eventConfig = ((TableData.gTable).BaseAdventureEventData)[config.event_id]
            if AdventureEventType.Reward >= eventConfig.type or eventConfig.type ~= AdventureEventType.Building or (AdventureData.BuildingInfo)[tonumber(eventConfig.parameter)] == nil then
              (table.insert)(events, {NodeId = node, EventId = config.event_id, Index = #events})
              leftEndurance = leftEndurance - 1
              step = 0
            end
          end
          -- DECOMPILER ERROR at PC98: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC98: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC98: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC98: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC98: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if AdventureData.MAX_CHOOSE_EVENT > #events and leftEndurance > 0 then
    return events
  end
end

-- DECOMPILER ERROR at PC294: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.InitFCEnhanceEffect = function(...)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  AdventureData.FCEnhanceEffect = {}
  for k,v in pairs((TableData.gTable).BaseAdventureBattlePowerData) do
    (table.insert)(AdventureData.FCEnhanceEffect, v)
  end
  ;
  (table.sort)(AdventureData.FCEnhanceEffect, function(x, y, ...)
    -- function num : 0_10_0
    do return x.battle_power_max < y.battle_power_max end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC297: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetFCEnhanceEffect = function(fc, ...)
  -- function num : 0_11 , upvalues : _ENV
  if AdventureData.FCEnhanceEffect == nil then
    (AdventureData.InitFCEnhanceEffect)()
  end
  local count = #AdventureData.FCEnhanceEffect
  local data = nil
  for i = count, 1, -1 do
    data = (AdventureData.FCEnhanceEffect)[i]
    if data.battle_power_max < fc then
      return data.battle_power_percent / 10000
    end
  end
  return 0
end

-- DECOMPILER ERROR at PC300: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.InitWishRewards = function(...)
  -- function num : 0_12 , upvalues : _ENV
  local item, reward, range, singleReward, count = nil, nil, nil, nil, nil
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  AdventureData.AllWishRewards = {}
  for k,v in pairs((TableData.gTable).BaseAdventureRewardPoolData) do
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R10 in 'UnsetPending'

    if v.type == AdventureRewardType.Wish then
      if (AdventureData.AllWishRewards)[v.reward_pool] == nil then
        (AdventureData.AllWishRewards)[v.reward_pool] = {}
      end
      item = {
Reward = {}
}
      reward = split(v.reward, ",")
      count = #reward
      for i = 1, count do
        singleReward = split(reward[i], ":")
        ;
        (table.insert)(item.Reward, {type = tonumber(singleReward[1]), id = tonumber(singleReward[2]), value = tonumber(singleReward[3])})
      end
      range = split(v.level_range, ":")
      item.Floor = tonumber(range[1])
      item.Ceil = tonumber(range[2])
      item.FateType = v.show_fate_type
      item.FateDes = v.show_fate_des
      ;
      (table.insert)((AdventureData.AllWishRewards)[v.reward_pool], item)
    end
  end
  for k,v in pairs(AdventureData.AllWishRewards) do
    (table.sort)(v, function(x, y, ...)
    -- function num : 0_12_0
    do return x.Floor < y.Floor end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  -- DECOMPILER ERROR at PC104: Confused about usage of register: R5 in 'UnsetPending'

  AdventureData.WishRewards = {}
  for k,v in pairs((TableData.gTable).BaseAdventureWishData) do
    -- DECOMPILER ERROR at PC114: Confused about usage of register: R10 in 'UnsetPending'

    (AdventureData.WishRewards)[v.type] = v
  end
end

-- DECOMPILER ERROR at PC303: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetWishReward = function(type, ...)
  -- function num : 0_13 , upvalues : _ENV
  if (_G.next)(AdventureData.WishRewards) == nil then
    (AdventureData.InitWishRewards)()
  end
  local rewards = {}
  local rewardPool = split(((AdventureData.WishRewards)[type]).reward_pool, ",")
  local count = #rewardPool
  local data = nil
  local playerLevel = ((ActorData.GetLevel)())
  local subCount, subData, poolInfo = nil, nil, nil
  for i = 1, count do
    poolInfo = split(rewardPool[i], ":")
    data = (AdventureData.AllWishRewards)[tonumber(poolInfo[1])]
    subCount = #data
    for j = 1, subCount do
      subData = data[j]
      if subData.Floor <= playerLevel and playerLevel <= subData.Ceil then
        (table.insert)(rewards, {PoolId = tonumber(poolInfo[1]), Data = subData})
        break
      end
    end
  end
  return rewards
end

-- DECOMPILER ERROR at PC306: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetNextLevelWishReward = function(type, ...)
  -- function num : 0_14 , upvalues : _ENV
  local rewards = {}
  local rewardPool = split(((AdventureData.WishRewards)[type]).reward_pool, ",")
  local count = #rewardPool
  local data = nil
  local playerLevel = (ActorData.GetLevel)()
  local nextLevel = 0
  local subCount, subData, poolInfo = nil, nil, nil
  for i = 1, count do
    poolInfo = split(rewardPool[i], ":")
    data = (AdventureData.AllWishRewards)[tonumber(poolInfo[1])]
    subCount = #data
    for j = 1, subCount do
      subData = data[j]
      if subData.Floor <= playerLevel and playerLevel <= subData.Ceil and nextLevel == 0 then
        nextLevel = subData.Ceil + 1
      else
        if subData.Floor <= nextLevel and nextLevel <= subData.Ceil then
          (table.insert)(rewards, {PoolId = tonumber(poolInfo[1]), Data = subData})
          break
        end
      end
    end
  end
  return rewards
end

-- DECOMPILER ERROR at PC309: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetTarotResultInfo = function(poolId, ...)
  -- function num : 0_15 , upvalues : _ENV
  if poolId == 0 then
    return -1
  else
    local data = (AdventureData.GetWishRewardInfo)(AdventureWishRewardType.Tarot, poolId)
    return data.FateType
  end
end

-- DECOMPILER ERROR at PC312: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetWishRewardInfo = function(type, poolId, ...)
  -- function num : 0_16 , upvalues : _ENV
  local rewards = (AdventureData.GetWishReward)(type)
  local count = #rewards
  for i = 1, count do
    if (rewards[i]).PoolId == poolId then
      return (rewards[i]).Data
    end
  end
end

-- DECOMPILER ERROR at PC315: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetBattleBg = function(...)
  -- function num : 0_17 , upvalues : _ENV
  return (AdventureData.CurrentMapConfig).background_path
end

-- DECOMPILER ERROR at PC318: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetBattleBGM = function(...)
  -- function num : 0_18 , upvalues : _ENV
  return (AdventureData.CurrentMapConfig).bgm_id
end

-- DECOMPILER ERROR at PC321: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.InitBulletScreenData = function(...)
  -- function num : 0_19 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  AdventureData.MaxBulletAmount = (((TableData.gTable).BaseFixedData)[Const.MAX_BULLETSCREEN]).int_value
  ;
  (AdventureData.SetSingleBulletPool)(AdventureData.BulletsSizePool, Const.BULLETSCREEN_SIZE, function(value, ...)
    -- function num : 0_19_0 , upvalues : _ENV
    local size = tonumber(value)
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (AdventureData.CurrentBulletStatue)[size] = {Index = 0, MaxIndex = (math.floor)(DesignScreen.height / (size + AdventureData.BulletLineGap)), Round = 0}
    return size
  end
)
  ;
  (AdventureData.SetSingleBulletPool)(AdventureData.BulletsSpeedPool, Const.BULLETSCREEN_SPEED, function(value, ...)
    -- function num : 0_19_1 , upvalues : _ENV
    return tonumber(value)
  end
)
  ;
  (AdventureData.SetSingleBulletPool)(AdventureData.BulletsColorPool, Const.BULLETSCREEN_COLOR, function(value, ...)
    -- function num : 0_19_2
    return value
  end
)
end

-- DECOMPILER ERROR at PC324: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.SetSingleBulletPool = function(pool, id, handler, ...)
  -- function num : 0_20 , upvalues : _ENV
  local datas = split((((TableData.gTable).BaseFixedData)[id]).array_value, ",")
  local count = #datas
  local chance = 0
  local eachData = nil
  for i = 1, count do
    eachData = split(datas[i], ":")
    chance = chance + tonumber(eachData[2])
    ;
    (table.insert)(pool, {Value = handler(eachData[1]), Chance = chance})
  end
end

-- DECOMPILER ERROR at PC327: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetBuildingProduceSpeed = function(id, enhance, ...)
  -- function num : 0_21 , upvalues : _ENV
  local config = ((TableData.gTable).BaseAdventureBuildingData)[id]
  local countInfos = split(config.every_count, ":")
  local itemInfos = split(config.item, ":")
  local duration = tonumber(countInfos[2])
  local times = tonumber(countInfos[1])
  local count = tonumber(itemInfos[3])
  local speed = 3600 / duration * times
  speed = speed * count
  if enhance then
    speed = speed * (1 + enhance)
  end
  if speed < 1 then
    speed = duration / times / count / 3600
    return "x 1/" .. (string.format)("%.1f", speed) .. (PUtil.get)(60000097)
  else
    return "x " .. GetFormatedCount((math.floor)(speed)) .. "/" .. (PUtil.get)(60000097)
  end
end

-- DECOMPILER ERROR at PC330: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetMiniGameRewardInfo = function(type, status, ...)
  -- function num : 0_22 , upvalues : _ENV
  if (AdventureData.MiniGameRewards)[type] == nil then
    (AdventureData.InitMiniGameReward)(type)
  end
  local count = #((AdventureData.MiniGameRewards)[type])[status]
  for i = count, 1, -1 do
    if ((((AdventureData.MiniGameRewards)[type])[status])[i]).Level <= (ActorData.GetLevel)() then
      return (((AdventureData.MiniGameRewards)[type])[status])[i]
    end
  end
end

-- DECOMPILER ERROR at PC333: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GetMiniGameRewardInfo = function(type, status, ...)
  -- function num : 0_23 , upvalues : _ENV
  if (AdventureData.MiniGameRewards)[type] == nil then
    (AdventureData.InitMiniGameReward)(type)
  end
  local count = #((AdventureData.MiniGameRewards)[type])[status]
  for i = count, 1, -1 do
    if ((((AdventureData.MiniGameRewards)[type])[status])[i]).Level <= (ActorData.GetLevel)() then
      return (((AdventureData.MiniGameRewards)[type])[status])[i]
    end
  end
end

-- DECOMPILER ERROR at PC336: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.InitMiniGameReward = function(type, ...)
  -- function num : 0_24 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (AdventureData.MiniGameRewards)[type] = {}
  local minLv, lvs = nil, nil
  if type == AdventureEventType.Brick or type == AdventureEventType.Goldmine then
    local poolRewardIds = {}
    local excelTable = nil
    if type == AdventureEventType.Brick then
      excelTable = (TableData.gTable).BaseAdventureGameBrickData
    else
      if type == AdventureEventType.Goldmine then
        excelTable = (TableData.gTable).BaseAdventureGameMineralData
      end
    end
    for k,v in pairs(excelTable) do
      if v.reward_pool ~= 0 then
        poolRewardIds[v.reward_pool] = true
      end
    end
    for k,v in pairs(poolRewardIds) do
      for subk,subv in pairs((TableData.gTable).BaseAdventureRewardPoolData) do
        -- DECOMPILER ERROR at PC67: Confused about usage of register: R15 in 'UnsetPending'

        if subv.reward_pool == k then
          if ((AdventureData.MiniGameRewards)[type])[subv.reward_pool] == nil then
            ((AdventureData.MiniGameRewards)[type])[subv.reward_pool] = {}
          end
          lvs = split(subv.level_range, ":")
          minLv = tonumber(lvs[1])
          ;
          (table.insert)(((AdventureData.MiniGameRewards)[type])[subv.reward_pool], {Level = minLv, Rewards = subv.reward, Id = subk})
        end
      end
    end
  else
    do
      local poolId = nil
      for k,v in pairs((TableData.gTable).BaseAdventureEventData) do
        if v.type == type then
          poolId = v.reward_pool
          break
        end
      end
      do
        for k,v in pairs((TableData.gTable).BaseAdventureRewardPoolData) do
          -- DECOMPILER ERROR at PC130: Confused about usage of register: R9 in 'UnsetPending'

          if v.reward_pool == poolId then
            if ((AdventureData.MiniGameRewards)[type])[v.type] == nil then
              ((AdventureData.MiniGameRewards)[type])[v.type] = {}
            end
            lvs = split(v.level_range, ":")
            minLv = tonumber(lvs[1])
            ;
            (table.insert)(((AdventureData.MiniGameRewards)[type])[v.type], {Level = minLv, Rewards = v.reward, Id = k})
          end
        end
        do
          for k,v in pairs((AdventureData.MiniGameRewards)[type]) do
            (table.sort)(R9_PC165, function(x, y, ...)
    -- function num : 0_24_0
    do return x.Level < y.Level end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC339: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.GenerateTarotResultList = function(...)
  -- function num : 0_25 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (AdventureData.TarotResultInfo).List = {}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((AdventureData.TarotResultInfo).List)[(AdventureData.TarotResultInfo).Index] = AdventureData.TarotResult + 1
  local used = {1, 2, 3, 4, 5}
  local index = 1
  used[AdventureData.TarotResult + 1] = nil
  while 1 do
    local result = (math.random)(1, AdventureData.MAX_TAROT_RESULT)
    if used[result] ~= nil then
      used[result] = nil
      if index == (AdventureData.TarotResultInfo).Index then
        index = index + 1
      end
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((AdventureData.TarotResultInfo).List)[index] = result
      index = index + 1
      if index == (AdventureData.TarotResultInfo).Index then
        index = index + 1
      end
    end
  end
  do
    if (_G.next)(used) ~= nil then
      local str = tostring((AdventureData.TarotResultInfo).Index)
      for i = 1, AdventureData.MAX_TAROT_RESULT do
        str = str .. ":" .. tostring(((AdventureData.TarotResultInfo).List)[i])
      end
      ;
      (Util.SetPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_TAROT_RESULT, str)
    end
  end
end

-- DECOMPILER ERROR at PC342: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.SetTarotResultList = function(...)
  -- function num : 0_26 , upvalues : _ENV
  if (_G.next)(AdventureData.TarotResultInfo) == nil then
    local str = (Util.GetPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_TAROT_RESULT)
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

    if (Util.CheckNullString)(str) then
      (AdventureData.TarotResultInfo).Index = 0
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (AdventureData.TarotResultInfo).List = (AdventureData.GenerateTarotResultList)()
    else
      local info = split(str, ":")
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (AdventureData.TarotResultInfo).Index = tonumber(info[1])
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (AdventureData.TarotResultInfo).List = {}
      local count = #info
      for i = 2, count do
        (table.insert)((AdventureData.TarotResultInfo).List, tonumber(info[i]))
      end
    end
  end
end

-- DECOMPILER ERROR at PC345: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.CheckFreeCtrlDice = function(...)
  -- function num : 0_27 , upvalues : _ENV
  local cost = (AdventureData.GetCtrlDiceCost)()
  do
    if cost ~= nil then
      local costInfo = split(cost, ":")
      return tonumber(costInfo[3]) == 0
    end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC348: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.CheckBuildingRedDot = function(...)
  -- function num : 0_28 , upvalues : _ENV
  for k,v in pairs(AdventureData.BuildingInfo) do
    if (v.totalOutput)[1] == nil or ((v.totalOutput)[1]).value < ((v.upperOutput)[1]).value then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC351: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.PopScreenBulletContent = function(...)
  -- function num : 0_29 , upvalues : _ENV
  if #AdventureData.TaroChatData == 0 then
    return nil
  end
  local content = (table.remove)(AdventureData.TaroChatData, 1)
  return content
end

-- DECOMPILER ERROR at PC354: Confused about usage of register: R0 in 'UnsetPending'

AdventureData.PushScreenBulletContent = function(data, first, ...)
  -- function num : 0_30 , upvalues : _ENV
  if first then
    (table.insert)(AdventureData.TaroChatData, 1, data)
  else
    ;
    (table.insert)(AdventureData.TaroChatData, data)
  end
end


