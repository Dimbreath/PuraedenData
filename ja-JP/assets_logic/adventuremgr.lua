-- params : ...
-- function num : 0 , upvalues : _ENV
AdventureMgr = {}
local _lastReqType = nil
local _requestingWish = false
-- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.TryOpenAdventureUI = function(...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  if AdventureData.Initialized == false then
    AdventureData.InitOperate = AdventureInitType.OpenUI
    ;
    (AdventureService.ReqAdventureInit)()
  else
    ;
    (AdventureMgr.OpenAdventureUI)()
  end
end

-- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.TryRefreshData = function(...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  AdventureData.InitOperate = AdventureInitType.Refresh
  ;
  (AdventureService.ReqAdventureInit)()
end

-- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.TryOpenSubFunc = function(callback, ...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.InitOperate = AdventureInitType.OpenSubFunc
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.AfterInitCallback = callback
  ;
  (AdventureService.ReqAdventureInit)()
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.AfterRecvData = function(msg, ...)
  -- function num : 0_3 , upvalues : _ENV
  (AdventureData.InitData)(msg)
  if AdventureData.InitOperate == AdventureInitType.Refresh then
    UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH)
  else
    if AdventureData.InitOperate == AdventureInitType.OpenSubFunc then
      (AdventureMgr.OpenAdventureUI)()
      if AdventureData.AfterInitCallback ~= nil then
        (AdventureData.AfterInitCallback)()
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

        AdventureData.AfterInitCallback = nil
      end
    else
      ;
      (AdventureMgr.OpenAdventureUI)()
    end
    ;
    (AdventureService.ReqAdventureBuilding)(AdventureBuildingOperateType.RequestInfo)
  end
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.OpenAdventureUI = function(...)
  -- function num : 0_4 , upvalues : _ENV
  (GuideMgr.InGuideOpenWindow)((WinResConfig.AdventureGameWindow).name)
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.TryPlaySingleDice = function(...)
  -- function num : 0_5 , upvalues : _ENV, _lastReqType
  if not (Util.CheckCostResources)(PropType.ASSET .. ":" .. AssetType.ENDURANCE .. ":" .. (AdventureData.CurrentMapConfig).dice_cost) then
    return 
  end
  _lastReqType = AdventureDiceType.Single
  ;
  (AdventureMgr.PlayDice)(1)
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.TryPlayMultiDice = function(...)
  -- function num : 0_6 , upvalues : _ENV
  if not (Util.CheckCostResources)(PropType.ASSET .. ":" .. AssetType.ENDURANCE .. ":" .. (AdventureData.CurrentMapConfig).dice_cost) then
    return 
  end
  ;
  (AdventureData.ResetChosedEvent)()
  OpenWindow((WinResConfig.TenTimeUIWindow).name, UILayer.HUD, (AdventureData.GetNextPotentialEvents)(AdventureData.CurrentNode))
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.TryCtrlDice = function(...)
  -- function num : 0_7 , upvalues : _ENV
  if AdventureData.LeftStep > 0 then
    return 
  end
  local times = (Util.GetIntPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_MOVE_TIMES)
  if times < AdventureData.FIXED_MOVE_TIMES then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000299, AdventureData.FIXED_MOVE_TIMES - times))
    return 
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.CtrlDiceCost = (AdventureData.GetCtrlDiceCost)()
  if AdventureData.CtrlDiceCost == nil then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000101))
  else
    OpenWindow((WinResConfig.ControlChoiceWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.TryOpenBuildingShow = function(...)
  -- function num : 0_8 , upvalues : _ENV
  if AdventureData.LeftStep > 0 then
    return 
  end
  if (_G.next)(AdventureData.BuildingInfo) == nil then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000104))
    return 
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  AdventureData.OpeningBuildingUI = true
  ;
  (AdventureService.ReqAdventureBuilding)(AdventureBuildingOperateType.RequestInfo)
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.PlayMultiDice = function(...)
  -- function num : 0_9 , upvalues : _ENV, _lastReqType
  local specifyNodes = {}
  for k,v in pairs(AdventureData.ChosedEvent) do
    (table.insert)(specifyNodes, v)
  end
  ;
  (table.sort)(specifyNodes, function(x, y, ...)
    -- function num : 0_9_0
    do return x.Index < y.Index end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local sortedNodes = {}
  local count = #specifyNodes
  for i = 1, count do
    (table.insert)(sortedNodes, (specifyNodes[i]).NodeId)
  end
  local str = ""
  for i = 1, count do
    str = str .. " " .. tostring(sortedNodes[i])
  end
  logw("sorted:" .. str)
  _lastReqType = AdventureDiceType.Multiply
  ;
  (AdventureMgr.PlayDice)(AdventureData.MULTI_DICE_NUMBER, sortedNodes)
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.PlayDice = function(times, specifyNodes, ...)
  -- function num : 0_10 , upvalues : _ENV
  (AdventureService.ReqPlayDice)(nil, nil, times, specifyNodes)
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.PlayCtrlDice = function(dice, ...)
  -- function num : 0_11 , upvalues : _ENV, _lastReqType
  if not (Util.CheckCostResources)(PropType.ASSET .. ":" .. AssetType.ENDURANCE .. ":" .. (AdventureData.CurrentMapConfig).dice_cost) then
    return 
  end
  ;
  (MessageMgr.OpenCostResConfirmWindow)(60000520, AdventureData.CtrlDiceCost, function(...)
    -- function num : 0_11_0 , upvalues : _lastReqType, _ENV, dice
    _lastReqType = AdventureDiceType.Remote
    ;
    (AdventureService.ReqPlayDice)(dice)
  end
, nil, nil, true)
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.RecvPlayDice = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV, _lastReqType
  local times = (Util.GetIntPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_MOVE_TIMES)
  ;
  (Util.SetIntPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_MOVE_TIMES, times + 1)
  local currentLeftStep = AdventureData.LeftStep
  ;
  (AdventureMgr.InitDiceData)(msg)
  UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_CHANGE_DRAG_STATUE, false)
  if currentLeftStep <= 0 then
    if _lastReqType == AdventureDiceType.Multiply then
      local str = "掷出："
      local count = #msg.diceNum
      for i = 1, count do
        str = str .. " " .. tostring((msg.diceNum)[i])
      end
      ;
      (MessageMgr.OpenSoloConfirmWindow)(str, function(...)
    -- function num : 0_12_0 , upvalues : _ENV, msg
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (GRoot.inst).touchable = false
    ;
    (AdventureMgr.AfterPlayDice)(msg)
  end
)
    else
      do
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (GRoot.inst).touchable = false
        UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_PLAY_DICE_ANIM, {Number = (msg.diceNum)[1], Remote = _lastReqType == AdventureDiceType.Remote, Callback = function(...)
    -- function num : 0_12_1 , upvalues : _ENV, msg
    (AdventureMgr.AfterPlayDice)(msg)
  end
})
        ;
        (AdventureMgr.MoveToNextNode)(AdventureData.ChosedFork)
        local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[(ActorData.GetLevel)() + 72300000]
        local curValue = (ActorData.GetAssetCount)(AssetType.ENDURANCE)
        if curValue / LevelUpData.max_sta < 0.8 then
          (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureGameWindow).name, RedDotComID.BigAdventure_Vit)
        end
        _lastReqType = nil
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.ChooseNextNode = function(nodeId, ...)
  -- function num : 0_13 , upvalues : _ENV
  (AdventureService.ReqPlayDice)(nil, nodeId)
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.Move = function(...)
  -- function num : 0_14 , upvalues : _ENV
  if UIMgr:IsWindowOpen((WinResConfig.AdventureGameWindow).name) == false then
    return 
  end
  local currentNodeConfig = ((TableData.gTable).BaseAdventureNodeData)[AdventureData.CurrentMoveNode]
  if AdventureData.LeftStep > 0 then
    if currentNodeConfig.type == AdventureNodeType.End then
      UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_CHANGE_STATUE, {Move = false})
      ;
      (AdventureMgr.ChangeToTargetMap)()
    else
      UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_CHANGE_STATUE, {Move = true})
      local haveNode, nodeId = (AdventureMgr.GetNextNode)(currentNodeConfig)
      if haveNode then
        (AdventureMgr.MoveToNextNode)(nodeId)
      else
        UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_SHOW_CHOOSE_FORK, nodeId)
      end
    end
  else
    do
      UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_CHANGE_DRAG_STATUE, true)
      if currentNodeConfig.type == AdventureNodeType.End then
        (AdventureMgr.ChangeToTargetMap)()
      else
        -- DECOMPILER ERROR at PC94: Confused about usage of register: R1 in 'UnsetPending'

        AdventureData.CurrentNode = AdventureData.TargetNode
        -- DECOMPILER ERROR at PC96: Confused about usage of register: R1 in 'UnsetPending'

        AdventureData.CurrentMoveNode = 0
        ;
        (AdventureMgr.ShowTenTimeResult)()
      end
      -- DECOMPILER ERROR at PC102: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (GRoot.inst).touchable = true
      UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_CHANGE_STATUE, {Move = false, SetDir = true})
    end
  end
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.QuitWhenMoving = function(...)
  -- function num : 0_15 , upvalues : _ENV
  if AdventureData.LeftStep > 0 then
    local node = (tonumber((((TableData.gTable).BaseAdventureNodeData)[AdventureData.CurrentMoveNode]).next))
    local config = nil
    while AdventureData.LeftStep > 0 do
      config = ((TableData.gTable).BaseAdventureNodeData)[node]
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

      if config.type ~= AdventureNodeType.End then
        AdventureData.LeftStep = AdventureData.LeftStep - 1
      end
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

      if (AdventureData.EventPoint)[AdventureData.LeftStep] ~= nil then
        (AdventureData.PassedNode)[node] = true
      end
      node = tonumber(config.next)
    end
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

    AdventureData.CurrentNode = AdventureData.TargetNode
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

    AdventureData.CurrentMapConfig = ((TableData.gTable).BaseAdventureMapData)[AdventureData.TargetMap]
  end
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.GetNextNode = function(nodeConfig, ...)
  -- function num : 0_16 , upvalues : _ENV
  if nodeConfig.type == AdventureNodeType.ForkBegin then
    local nodes = split(nodeConfig.next, ":")
    if #AdventureData.Rewards > 1 then
      return true, tonumber(nodes[nodeConfig.index])
    else
      return false, nodes
    end
  else
    do
      do return true, tonumber(nodeConfig.next) end
    end
  end
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.ShowTenTimeResult = function(...)
  -- function num : 0_17 , upvalues : _ENV
  if #AdventureData.Rewards > 1 then
    local rewards = {}
    local count = #AdventureData.Rewards
    local subCount = nil
    for i = 1, count do
      subCount = #((AdventureData.Rewards)[i]).rewards
      for j = 1, subCount do
        (table.insert)(rewards, (((AdventureData.Rewards)[i]).rewards)[j])
      end
    end
    OpenWindow((WinResConfig.TenTimeResultWindow).name, UILayer.HUD, rewards, AdventureData.TirggeredEvent)
  end
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.MoveToNextNode = function(nodeId, ...)
  -- function num : 0_18 , upvalues : _ENV
  local arg = {}
  arg.NodeId = nodeId
  arg.Callback = function(...)
    -- function num : 0_18_0 , upvalues : _ENV, nodeId
    if UIMgr:IsWindowOpen((WinResConfig.AdventureGameWindow).name) == false then
      return 
    end
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    AdventureData.CurrentMoveNode = nodeId
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

    if (((TableData.gTable).BaseAdventureNodeData)[AdventureData.CurrentMoveNode]).type ~= AdventureNodeType.End then
      AdventureData.LeftStep = AdventureData.LeftStep - 1
    end
    if (AdventureData.EventPoint)[AdventureData.LeftStep] ~= nil then
      local config = ((TableData.gTable).BaseAdventureNodeData)[AdventureData.CurrentMoveNode]
      local eventConfig = nil
      if config.event_id ~= 0 then
        eventConfig = ((TableData.gTable).BaseAdventureEventData)[config.event_id]
        if AdventureEventType.Reward < eventConfig.type and (eventConfig.type ~= AdventureEventType.Building or (AdventureData.BuildingInfo)[tonumber(eventConfig.parameter)] == nil) then
          (table.insert)(AdventureData.TirggeredEvent, {NodeId = AdventureData.CurrentMoveNode, EventId = config.event_id})
        end
      end
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (AdventureData.PassedNode)[AdventureData.CurrentMoveNode] = true
      if AdventureData.LeftStep <= 0 then
        if #AdventureData.TirggeredEvent == 1 then
          (AdventureMgr.TriggerEvent)(eventConfig.type, config.id, tonumber(eventConfig.parameter))
        else
          if #AdventureData.Rewards == 1 then
            local rewards = ((AdventureData.Rewards)[1]).rewards
            if (rewards[#rewards]).id == AssetType.GOLD then
              (LuaSound.PlaySound)(LuaSound.ADVENTURE_ACQUIRE_GOLD, SoundBank.OTHER)
            end
            ;
            (MessageMgr.OpenItemBuyTipsWindowBySingle)({id = (rewards[#rewards]).id, Num = (rewards[#rewards]).value})
            UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_NODE_ANIM, {NodeId = nodeId})
          end
        end
      end
      do
        do
          UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_FINISH_NODE_ANIM)
          ;
          (AdventureMgr.Move)()
        end
      end
    end
  end

  UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_ROLE_MOVE, arg)
end

-- DECOMPILER ERROR at PC63: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.TriggerEvent = function(type, nodeId, bulidingID, ...)
  -- function num : 0_19 , upvalues : _ENV
  if type == AdventureEventType.Building then
    OpenWindow((WinResConfig.BuildingUseWindow).name, UILayer.HUD, bulidingID, nodeId)
  else
    if type == AdventureEventType.Battle then
      (AdventureService.ReqInitAdventureBattleEmba)(nodeId)
    else
      if type == AdventureEventType.RPS then
        OpenWindow((WinResConfig.AdventureMiniRPSGameWindow).name, UILayer.HUD, nodeId)
      else
        if type == AdventureEventType.Question then
          OpenWindow((WinResConfig.AdventureGame_Question).name, UILayer.HUD, nodeId)
        else
          if type == AdventureEventType.Brick then
            OpenWindow((WinResConfig.AdventureGame_BrickGame).name, UILayer.HUD, nodeId)
          else
            if type == AdventureEventType.Goldmine then
              OpenWindow((WinResConfig.AdventureGame_GoldGame).name, UILayer.HUD, nodeId)
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC66: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.ChangeToTargetMap = function(...)
  -- function num : 0_20 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  AdventureData.PassedNode = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  AdventureData.CurrentMapConfig = ((TableData.gTable).BaseAdventureMapData)[AdventureData.TargetMap]
  UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_CHANGE_MAP, {MapId = AdventureData.TargetMap, NodeId = (AdventureData.CurrentMapConfig).head_node, Callback = function(...)
    -- function num : 0_20_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    AdventureData.CurrentMoveNode = (AdventureData.CurrentMapConfig).head_node
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

    AdventureData.LeftStep = AdventureData.LeftStep - 1
    UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_FINISH_NODE_ANIM)
    UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_SHOW_DESTINATION_MARKER)
    ;
    (AdventureMgr.Move)()
  end
})
end

-- DECOMPILER ERROR at PC69: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.InitDiceData = function(data, ...)
  -- function num : 0_21 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.TargetNode = data.nodeId
  if not AdventureData.WishAvailable and data.isWish then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.AdventrureWish)
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.WishAvailable = data.isWish
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  if AdventureData.WishPoint ~= data.wishPoint then
    AdventureData.WishPoint = data.wishPoint
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.PlayWishPointAnim = true
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.NeedChoose = data.chooseNext
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.TargetMap = data.mapId
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.UndoneEvent = data.undoneEvent
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.BoughtCtrlDice = data.boughtCtrlDice
  UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH_CTRL_REDDOT)
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.TarotStatue = data.isTarot
  -- DECOMPILER ERROR at PC57: Confused about usage of register: R1 in 'UnsetPending'

  if AdventureData.LeftStep <= 0 then
    AdventureData.LeftStep = 0
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.TirggeredEvent = {}
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.EventPoint = {}
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.Rewards = {}
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.PassingNode = {}
  end
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.CurrentMoveNode = AdventureData.CurrentNode
  local count = #data.diceNum
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R2 in 'UnsetPending'

  if AdventureData.StepToTarot > 0 then
    AdventureData.StepToTarot = AdventureData.StepToTarot - count
  end
  for i = 1, count do
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R6 in 'UnsetPending'

    AdventureData.LeftStep = AdventureData.LeftStep + (data.diceNum)[i]
  end
  local nodeId = tonumber((((TableData.gTable).BaseAdventureNodeData)[AdventureData.CurrentNode]).next)
  while 1 do
    local config = ((TableData.gTable).BaseAdventureNodeData)[nodeId]
    ;
    (table.insert)(AdventureData.PassingNode, nodeId)
    if config.id ~= AdventureData.TargetNode then
      do
        nodeId = tonumber(config.next)
        -- DECOMPILER ERROR at PC125: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC125: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local totalStep = AdventureData.LeftStep
  for i = 1, count do
    totalStep = totalStep - (data.diceNum)[i]
    -- DECOMPILER ERROR at PC137: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (AdventureData.EventPoint)[totalStep] = true
  end
  count = #data.rewards
  for i = 1, count do
    (table.insert)(AdventureData.Rewards, (data.rewards)[i])
  end
end

-- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.AfterPlayDice = function(data, ...)
  -- function num : 0_22 , upvalues : _ENV
  UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_FOCUS_ON_CHARACTER, AdventureMgr.Move)
  UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_SHOW_DESTINATION_MARKER)
end

-- DECOMPILER ERROR at PC75: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.EnterMakeWish = function(...)
  -- function num : 0_23 , upvalues : _ENV
  if AdventureData.LeftStep > 0 then
    return 
  end
  if AdventureData.WishAvailable then
    OpenWindow((WinResConfig.VowRewardChoiceWindow).name, UILayer.HUD, (AdventureData.GetWishReward)(AdventureWishRewardType.Adventure))
  else
    OpenWindow((WinResConfig.VowRewardUpWindow).name, UILayer.HUD, (AdventureData.GetWishReward)(AdventureWishRewardType.Adventure), (AdventureData.GetNextLevelWishReward)(AdventureWishRewardType.Adventure))
  end
end

-- DECOMPILER ERROR at PC78: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.OpenBuildingCardChoiceWindow = function(buildingId, totalFC, haveGuard, arg, ...)
  -- function num : 0_24 , upvalues : _ENV
  if haveGuard then
    local cards = (Util.clone)(AdventureData.AvailableCards)
    ;
    (table.insert)(cards, 1, arg.id)
    OpenWindow((WinResConfig.BuildingCardChoiceWindow).name, UILayer.HUD, buildingId, totalFC, haveGuard, arg, cards)
  else
    do
      OpenWindow((WinResConfig.BuildingCardChoiceWindow).name, UILayer.HUD, buildingId, totalFC, haveGuard, arg, AdventureData.AvailableCards)
    end
  end
end

-- DECOMPILER ERROR at PC81: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.UndoneEventsChange = function(...)
  -- function num : 0_25 , upvalues : _ENV
  if AdventureData.DealingEvent ~= nil then
    local count = #AdventureData.UndoneEvent
    for i = 1, count do
      if ((AdventureData.UndoneEvent)[i]).nodeId == AdventureData.DealingEvent then
        (table.remove)(AdventureData.UndoneEvent, i)
        if #AdventureData.UndoneEvent == 0 then
          UIMgr:RemoveWindowList((WinResConfig.UnMakeEventWindow).name)
        end
        break
      end
    end
    do
      UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH_UNDONE_EVENT)
      UIMgr:SendWindowMessage((WinResConfig.UnMakeEventWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH_UNDONE_EVENT)
      count = #AdventureData.TirggeredEvent
      for i = 1, count do
        if ((AdventureData.TirggeredEvent)[i]).NodeId == AdventureData.DealingEvent then
          (table.remove)(AdventureData.TirggeredEvent, i)
          break
        end
      end
      do
        -- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

        AdventureData.DealingEvent = nil
        UIMgr:SendWindowMessage((WinResConfig.TenTimeResultWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH_UNDONE_EVENT)
      end
    end
  end
end

-- DECOMPILER ERROR at PC84: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.OpenBuildingUI = function(...)
  -- function num : 0_26 , upvalues : _ENV
  if (_G.next)(AdventureData.Buildings) == nil then
    (AdventureData.InitAllBuildings)()
  end
  ;
  (table.sort)(AdventureData.Buildings, function(x, y, ...)
    -- function num : 0_26_0 , upvalues : _ENV
    if (AdventureData.BuildingInfo)[x] ~= nil and (AdventureData.BuildingInfo)[y] == nil then
      return true
    else
      if (AdventureData.BuildingInfo)[x] == nil and (AdventureData.BuildingInfo)[y] ~= nil then
        return false
      else
        return x < y
      end
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  OpenWindow((WinResConfig.BuildingShowWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC87: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.OpenTarotUI = function(...)
  -- function num : 0_27 , upvalues : _ENV
  if AdventureData.LeftStep > 0 then
    return 
  end
  if AdventureData.TarotStatue == AdventureTarotStatue.NotOpen then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000102, AdventureData.StepToTarot))
  else
    if (_G.next)(AdventureData.WishRewards) == nil then
      (AdventureData.InitWishRewards)()
    end
    if AdventureData.MaxBulletAmount == 0 then
      (AdventureData.InitBulletScreenData)()
    end
    ;
    (AdventureService.ReqGetChat)()
  end
end

-- DECOMPILER ERROR at PC90: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.ReqPickTarotCard = function(index, ...)
  -- function num : 0_28 , upvalues : _requestingWish, _ENV
  if _requestingWish then
    return 
  end
  if AdventureData.TarotStatue == AdventureTarotStatue.NotOpen then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000102, AdventureData.StepToTarot))
    return 
  else
    if AdventureData.TarotStatue == AdventureTarotStatue.Played then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000103))
      return 
    end
  end
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (AdventureData.TarotResultInfo).Index = index
  _requestingWish = true
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_28_0 , upvalues : _requestingWish
    _requestingWish = false
  end
)
  ;
  (LuaSound.PlaySound)(LuaSound.ADVENTURE_FLIP_CARD, SoundBank.OTHER)
  ;
  (AdventureService.ReqWishReward)(AdventureWishType.Tarot)
end

-- DECOMPILER ERROR at PC93: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.CheckBuildingEvent = function(undone, nodeId, ...)
  -- function num : 0_29 , upvalues : _ENV
  UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH_UNDONE_EVENT)
end

-- DECOMPILER ERROR at PC96: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.AfterMakeWish = function(msg, ...)
  -- function num : 0_30 , upvalues : _requestingWish, _ENV
  _requestingWish = false
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if msg.type == AdventureWishType.Wish then
    AdventureData.WishAvailable = false
    ;
    (MessageMgr.ShowGetGoods)(msg.rewards)
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.TarotResult = (AdventureData.GetTarotResultInfo)(msg.rewardPoolId)
    ;
    (AdventureData.GenerateTarotResultList)()
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.TarotRewards = msg.rewards
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.TriggeredTarot = AdventureData.TriggeredTarot + 1
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

    if AdventureData.DailyTarotLimit <= AdventureData.TriggeredTarot then
      AdventureData.TarotStatue = AdventureTarotStatue.Played
    end
    UIMgr:SendWindowMessage((WinResConfig.TaroRewardChoiceWindow).name, (WindowMsgEnum.Adventure).E_MSG_SHOW_TAROT_RESULT)
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.NeedShowResult = true
  end
end

-- DECOMPILER ERROR at PC99: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.ChooseBuilding = function(data, ...)
  -- function num : 0_31 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if (AdventureData.ChosedEvent)[data.NodeId] == nil then
    (AdventureData.ChosedEvent)[data.NodeId] = data
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.ChosedEventAmount = AdventureData.ChosedEventAmount + 1
    return true
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (AdventureData.ChosedEvent)[data.NodeId] = nil
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

    AdventureData.ChosedEventAmount = AdventureData.ChosedEventAmount - 1
    return false
  end
end

-- DECOMPILER ERROR at PC102: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.EnterSetFormation = function(msg, ...)
  -- function num : 0_32 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.BattleFormation = msg.myCards
  local btnData = {}
  btnData.btnTxt = (PUtil.get)(20000021)
  btnData.fun = function(cards, ...)
    -- function num : 0_32_0 , upvalues : _ENV
    (AdventureService.ReqInAdventureBattleEmba)(AdventureData.BattleNode, false, (Util.CovertLoaclFormationToRemote)(cards))
  end

  local formationData = {}
  formationData.formationType = FormationType.Basic
  formationData.otherPlayerList = (Util.CovertRivalCardStateToLocal)(msg.rivalCards)
  formationData.myselfList = (Util.CovertRemoteFormationToLocal)(msg.myCards)
  formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).ADVENTURE
  formationData.BtnData = btnData
  formationData.stageId = AdventureData.BattleNode
  ;
  (MessageMgr.OpenFormationWindow)(formationData)
end

-- DECOMPILER ERROR at PC105: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.AfterBattle = function(msg, ...)
  -- function num : 0_33 , upvalues : _ENV
  if msg.isSuccess then
    local m = {}
    m.BattleType = (ProtoEnum.E_BATTLE_TYPE).ADVENTURE
    m.BasicGoods = (Util.GoodsObjectToItemDataModel)(msg.goods)
    local btn2 = {}
    btn2.btnTxt = (PUtil.get)(20000024)
    btn2.fun = function(...)
    -- function num : 0_33_0 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_33_0_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    else
      UIMgr:CloseWindow((WinResConfig.BattleWinConvergeWindow).name)
    end
  end

    m.btn2 = btn2
    ;
    (CommonWinMgr.OpenBattleSettleConvergeWindow)(m)
  else
    do
      local m = {}
      m.BattleType = (ProtoEnum.E_BATTLE_TYPE).ADVENTURE
      ;
      (CommonWinMgr.OpenBattleFailConvergeWindow)(m)
    end
  end
end

-- DECOMPILER ERROR at PC108: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.SendScreenBullet = function(content, ...)
  -- function num : 0_34 , upvalues : _ENV
  if (Util.StringIsNullOrEmpty)(content) then
    return 
  end
  ;
  (AdventureService.ReqSetChat)(content, (AdventureMgr.RandomBulletAttr)(AdventureData.BulletsSizePool), (AdventureMgr.RandomBulletAttr)(AdventureData.BulletsSpeedPool), (AdventureMgr.RandomBulletAttr)(AdventureData.BulletsColorPool, true))
end

-- DECOMPILER ERROR at PC111: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.RandomBulletAttr = function(pool, needIndex, ...)
  -- function num : 0_35 , upvalues : _ENV
  local value = (math.random)(1, 10000)
  local count = #pool
  for i = 1, count do
    if value <= (pool[i]).Chance then
      if needIndex then
        return i
      else
        return (pool[i]).Value
      end
    end
  end
end

-- DECOMPILER ERROR at PC114: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.ChooseGesture = function(nodeId, gesture, ...)
  -- function num : 0_36 , upvalues : _ENV
  local npcGesture, result = nil, nil
  if (Util.GetIntPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_MINI_GAME_WIN) == 0 then
    result = AdventureRewardType.Win
    npcGesture = gesture + 1
    if AdventureRPSGestureType.Paper < npcGesture then
      npcGesture = AdventureRPSGestureType.Rock
    end
    ;
    (Util.SetIntPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_MINI_GAME_WIN, 1)
  else
    ;
    (math.randomseed)((LuaTime.GetTimeStamp)())
    npcGesture = (math.random)(3) - 1
    if gesture == npcGesture then
      result = AdventureRewardType.Even
    else
      local diff = gesture - (npcGesture)
      if diff == -1 or diff == 2 then
        result = AdventureRewardType.Win
      else
        result = AdventureRewardType.Lose
      end
    end
  end
  do
    UIMgr:SendWindowMessage((WinResConfig.AdventureMiniRPSGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_SHOW_RPS_RESULT, {Self = gesture, NPC = npcGesture, Result = result})
    local rewardInfo = (AdventureData.GetMiniGameRewardInfo)(AdventureEventType.RPS, result)
    ;
    (AdventureService.ReqAdventureEventReward)(nodeId, AdventureEventType.RPS, false, {[1] = rewardInfo.Id})
  end
end

-- DECOMPILER ERROR at PC117: Confused about usage of register: R2 in 'UnsetPending'

AdventureMgr.AfterShowResult = function(...)
  -- function num : 0_37 , upvalues : _ENV
  local rewards = {}
  local count = #AdventureData.MiniGameRewardID
  local rewardStr = ""
  for i = 1, count do
    local config = ((TableData.gTable).BaseAdventureRewardPoolData)[(AdventureData.MiniGameRewardID)[i]]
    if i == 1 then
      rewardStr = config.reward
    else
      rewardStr = rewardStr .. "," .. config.reward
    end
  end
  if count > 0 then
    (MessageMgr.OpenRewardByStr)(rewardStr)
  end
end


