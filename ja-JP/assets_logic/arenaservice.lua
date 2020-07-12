-- params : ...
-- function num : 0 , upvalues : _ENV
ArenaService = {}
local _reqAcquireReward = false
-- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResArenaData, ArenaService.RecvAreanData)
  ;
  (Net.AddListener)((Proto.MsgName).ResArenaFight, ArenaService.RecvArenaFight)
  ;
  (Net.AddListener)((Proto.MsgName).ResArenaRefresh, ArenaService.RecvArenaRefresh)
  ;
  (Net.AddListener)((Proto.MsgName).ResArenaReward, ArenaService.RecvArenaReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResPlayBuyNum, ArenaService.RecvArenaBuyNum)
  ;
  (Net.AddListener)((Proto.MsgName).ResPlayClearCDTime, ArenaService.RecvArenaClearCDTime)
  ;
  (Net.AddListener)((Proto.MsgName).ResEmbattle, ArenaService.RecvArenaCardGroups)
  ;
  (Net.AddListener)((Proto.MsgName).ResBattleRcord, ArenaService.RecvArenaRecord)
  ;
  (Net.AddListener)((Proto.MsgName).ResArenaRank, ArenaService.RecvArenaRank)
  ;
  (Net.AddListener)((Proto.MsgName).ResUpdateRank, ArenaService.RecvUpdateRank)
  ;
  (Net.AddListener)((Proto.MsgName).ResBattleData, ArenaService.RecvBattleData)
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.ReqArenaData = function(op, ...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  ArenaData.LastReqOp = op
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqArenaData, m, (Proto.MsgName).ResArenaData)
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.RecvAreanData = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (ArenaMgr.AfterRecvData)(msg)
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.ReqArenaFight = function(rank, isSmash, formation, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.rank = rank
  m.isSweep = isSmash
  m.cardInfo = formation
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (ArenaData.BaseData).tempFormation = formation
  ;
  (Net.Send)((Proto.MsgName).ReqArenaFight, m, (Proto.MsgName).ResArenaFight)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.RecvArenaFight = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ArenaData.NeedShowTips = (ArenaData.BaseData).rank ~= (msg.arenaData).rank
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  if (ArenaData.BaseData).tempFormation ~= nil then
    (ArenaData.BaseData).arenaCardGroups = (ArenaData.BaseData).tempFormation
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (ArenaData.BaseData).tempFormation = nil
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (ArenaData.BaseData).rank = (msg.arenaData).rank
  loge("msg.arenaData.rank:" .. (msg.arenaData).rank)
  loge("msg.arenaData.seasonMaxRank:" .. (ArenaData.BaseData).seasonMaxRank)
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R1 in 'UnsetPending'

  if (ArenaData.BaseData).seasonMaxRank == 0 or (ArenaData.BaseData).rank > 0 and (ArenaData.BaseData).rank < (ArenaData.BaseData).seasonMaxRank then
    (ArenaData.BaseData).seasonMaxRank = (ArenaData.BaseData).rank
  end
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (ArenaData.BaseData).surNum = (msg.arenaData).surNum
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (ArenaData.BaseData).score = (msg.arenaData).score
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (ArenaData.BaseData).lastArenaFightTime = (msg.arenaData).lastArenaFightTime
  -- DECOMPILER ERROR at PC91: Confused about usage of register: R1 in 'UnsetPending'

  if #(msg.arenaData).arenRival > 0 then
    (ArenaData.BaseData).arenRival = (msg.arenaData).arenRival
    ;
    (table.sort)((ArenaData.BaseData).arenRival, function(x, y, ...)
    -- function num : 0_4_0
    do return x.rank < y.rank end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  -- DECOMPILER ERROR at PC102: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (ArenaData.BaseData).lastSuccess = msg.isSuccess
  ;
  (ArenaData.SaveFightResult)(msg)
  ;
  (ArenaData.SetCurrentCD)()
  ;
  (ArenaData.SortRewardData)()
  -- DECOMPILER ERROR at PC120: Confused about usage of register: R1 in 'UnsetPending'

  if msg.isSweep then
    (msg.arenaData).arenaCardGroups = (ArenaData.BaseData).arenaCardGroups
    ;
    (CommonWinMgr.OpenArenaBattleWindow)(msg)
    if UIMgr:IsWindowOpen((WinResConfig.ArenaWindow).name) then
      UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_CHALLENGE_CD)
      UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_CHALLENGE_TIMES)
    end
  end
  if (msg.arenaData).surNum <= 0 then
    (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureWindow).name, RedDotComID.Arena_UseTimes)
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.ReqArenaRefresh = function(...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqArenaRefresh, m, (Proto.MsgName).ResArenaRefresh)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.RecvArenaRefresh = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (ArenaData.BaseData).arenRival = msg.arenRival
  ;
  (table.sort)((ArenaData.BaseData).arenRival, function(x, y, ...)
    -- function num : 0_6_0
    do return x.rank < y.rank end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (ArenaData.BaseData).rank = msg.myRank
  UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_RIVAL)
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.ReqArenaReward = function(rewardId, operType, type, ...)
  -- function num : 0_7 , upvalues : _reqAcquireReward, _ENV
  if _reqAcquireReward then
    return 
  end
  _reqAcquireReward = true
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_7_0 , upvalues : _reqAcquireReward
    _reqAcquireReward = false
  end
)
  local m = {}
  m.rewardId = rewardId
  m.operType = operType
  m.type = type
  ;
  (Net.Send)((Proto.MsgName).ReqArenaReward, m, (Proto.MsgName).ResArenaReward)
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.RecvArenaReward = function(msg, ...)
  -- function num : 0_8 , upvalues : _reqAcquireReward, _ENV
  _reqAcquireReward = false
  if msg.type == ArenaRewardType.CareerReward then
    local rewards = {}
    local count = #msg.rewardId
    local config, infos, subCount, subInfos = nil, nil, nil, nil
    for i = 1, count do
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R11 in 'UnsetPending'

      (ArenaData.AcquiredReward)[(msg.rewardId)[i]] = true
      config = ((TableData.gTable).BaseArenaRewardData)[(msg.rewardId)[i]]
      infos = split(config.reward, ",")
      subCount = #infos
      for j = 1, subCount do
        subInfos = split(infos[j], ":")
        ;
        (table.insert)(rewards, {id = tonumber(subInfos[2]), type = tonumber(subInfos[1]), value = tonumber(subInfos[3])})
      end
    end
    ;
    (MessageMgr.ShowGetGoods)(rewards)
  else
    do
      local count = #msg.rewardId
      local config, infos, subCount, subInfos = nil, nil, nil, nil
      for i = 1, count do
        -- DECOMPILER ERROR at PC76: Confused about usage of register: R10 in 'UnsetPending'

        (ArenaData.AcquiredReward)[(msg.rewardId)[i]] = true
        config = ((TableData.gTable).BaseArenaRewardData)[(msg.rewardId)[i]]
        infos = split(config.reward, ",")
        subCount = #infos
        for j = 1, subCount do
          subInfos = split(infos[j], ":")
          ;
          (MessageMgr.OpenItemBuyTipsWindowBySingle)({id = tonumber(subInfos[2]), type = tonumber(subInfos[1]), Num = tonumber(subInfos[3])})
        end
      end
      do
        ;
        (ArenaData.SortRewardData)()
        UIMgr:SendWindowMessage((WinResConfig.ArenaRewardWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_REWARD)
        if msg.type == ArenaRewardType.CareerReward then
          (ArenaData.CheckCareerRewardRedDot)()
        else
          if msg.type == ArenaRewardType.DailyReward then
            (ArenaData.CheckDailyRewardRedDot)()
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.ReqArenaBuyNum = function(times, ...)
  -- function num : 0_9 , upvalues : _ENV
  local m = {}
  m.type = PlayType.Arena
  m.amount = times
  ;
  (Net.Send)((Proto.MsgName).ReqPlayBuyNum, m, (Proto.MsgName).ResPlayBuyNum)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.RecvArenaBuyNum = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if msg.type == PlayType.Arena then
    (ArenaData.BaseData).surNum = msg.num
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (ArenaData.BaseData).buyNum = msg.buyNum
    UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_CHALLENGE_TIMES)
  end
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.ReqArenaClearCDTime = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  m.type = PlayType.Arena
  ;
  (Net.Send)((Proto.MsgName).ReqPlayClearCDTime, m, (Proto.MsgName).ResPlayClearCDTime)
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.RecvArenaClearCDTime = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if msg.type == PlayType.Arena then
    (ArenaData.BaseData).lastArenaFightTime = msg.lastArenaFightTime
    UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_CHALLENGE_CD)
  end
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.ReqArenaGuardCardGroups = function(formation, ...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  m.type = (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_ARENA_GUARD
  m.cardInfo = (Util.CovertLoaclFormationToRemote)(formation)
  ;
  (Net.Send)((Proto.MsgName).ReqEmbattle, m, (Proto.MsgName).ResEmbattle)
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.RecvArenaCardGroups = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if msg.type == (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_ARENA_GUARD then
    (ArenaData.BaseData).guardCardGroups = msg.cardInfo
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(60000028))
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

    if msg.type == (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_ATTA then
      (ArenaData.BaseData).arenaCardGroups = msg.cardInfo
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(60000063))
    end
  end
  UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_FC)
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.ReqArenaAttackCardGroups = function(formation, ...)
  -- function num : 0_15 , upvalues : _ENV
  local m = {}
  m.type = (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_ATTA
  m.cardInfo = (Util.CovertLoaclFormationToRemote)(formation)
  ;
  (Net.Send)((Proto.MsgName).ReqEmbattle, m, (Proto.MsgName).ResEmbattle)
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.ReqArenaRecord = function(...)
  -- function num : 0_16 , upvalues : _ENV
  local m = {}
  m.battleType = (ProtoEnum.E_BATTLE_TYPE).ARENA
  ;
  (Net.Send)((Proto.MsgName).ReqBattleRcord, m, (Proto.MsgName).ResBattleRcord)
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.RecvArenaRecord = function(msg, ...)
  -- function num : 0_17 , upvalues : _ENV
  if msg.battleType ~= (ProtoEnum.E_BATTLE_TYPE).ARENA then
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ArenaData.CombatRecords = msg.records
  ;
  (table.sort)(ArenaData.CombatRecords, function(x, y, ...)
    -- function num : 0_17_0
    do return y.timestamp < x.timestamp end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (ArenaMgr.OpenRecordUI)()
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.ReqArenaRank = function(...)
  -- function num : 0_18 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqArenaRank, m, (Proto.MsgName).ResArenaRank)
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.RecvArenaRank = function(msg, ...)
  -- function num : 0_19 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ArenaData.RankData = msg.records
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ArenaData.BestRank = msg.bestRank
  ;
  (table.sort)(ArenaData.RankData, function(x, y, ...)
    -- function num : 0_19_0
    do return x.rank < y.rank end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (ArenaMgr.OpenRankUI)()
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.RecvUpdateRank = function(msg, ...)
  -- function num : 0_20 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (ArenaData.BaseData).rank = msg.rank
  UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_SELF_RANK)
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.ReqBattleData = function(id, ...)
  -- function num : 0_21 , upvalues : _ENV
  local m = {}
  m.battleIndex = id
  m.battleType = (ProtoEnum.E_BATTLE_TYPE).ARENA
  ;
  (Net.Send)((Proto.MsgName).ReqBattleData, m, (Proto.MsgName).ResBattleData)
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

ArenaService.RecvBattleData = function(msg, ...)
  -- function num : 0_22 , upvalues : _ENV
  (ArenaMgr.AfterRecvBattleData)(msg.battleCompleteData)
end

;
(ArenaService.Init)()

