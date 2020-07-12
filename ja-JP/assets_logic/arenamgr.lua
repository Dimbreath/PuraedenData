-- params : ...
-- function num : 0 , upvalues : _ENV
ArenaMgr = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.TryOpenArenaUI = function(callback, ...)
  -- function num : 0_0 , upvalues : _ENV
  local interval = (LuaTime.GetTimeStamp)() - ArenaData.LastEnterArenaTimestamp
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  if ArenaData.RefreshIntervel < interval then
    ArenaData.LastEnterArenaTimestamp = (LuaTime.GetTimeStamp)()
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

    ArenaData.AfterOpenCallback = callback
    ;
    (ArenaService.ReqArenaData)(ArenaRefreshDataType.OpenUI)
  else
    if (_G.next)(ArenaData.BaseData) ~= nil then
      (ArenaMgr.OpenArenaUI)()
    end
  end
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.AfterRecvData = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ArenaData.BaseData = msg.arenaData
  ;
  (table.sort)((ArenaData.BaseData).arenRival, function(x, y, ...)
    -- function num : 0_1_0
    do return x.rank < y.rank end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  PrintTable(msg)
  ;
  (ArenaData.SetCurrentCD)()
  ;
  (ArenaData.InitRewardsStatue)()
  if ArenaData.LastReqOp == ArenaRefreshDataType.OpenUI then
    (ArenaMgr.OpenArenaUI)()
    if ArenaData.AfterOpenCallback ~= nil then
      (ArenaData.AfterOpenCallback)()
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

      ArenaData.AfterOpenCallback = nil
    end
  else
    if ArenaData.LastReqOp == ArenaRefreshDataType.Challenge then
      UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_CHALLENGE)
    else
      if ArenaData.LastReqOp == ArenaRefreshDataType.Smash then
        UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_SMASH)
      else
        if ArenaData.LastReqOp == ArenaRefreshDataType.CountDown then
          UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_CHALLENGE_CD)
        else
          if ArenaData.LastReqOp == ArenaRefreshDataType.Rank then
            UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_INFO)
          end
        end
      end
    end
  end
  if msg.temp ~= nil and (msg.temp).isOpenPanel then
    if not (GuideMgr.IsPlayPictureGuide)((WinResConfig.ArenaWindow).name) then
      if (msg.temp).rank == 0 then
        OpenWindow((WinResConfig.ArenaNewSeasonWindow).name, UILayer.HUD, msg.temp)
      else
        OpenWindow((WinResConfig.ArenaSettleWindow).name, UILayer.HUD, msg.temp)
      end
    else
      UIMgr:SetOnHideComplete((WinResConfig.GuidePictureWindow).name, function(...)
    -- function num : 0_1_1 , upvalues : msg, _ENV
    if (msg.temp).rank == 0 then
      OpenWindow((WinResConfig.ArenaNewSeasonWindow).name, UILayer.HUD, msg.temp)
    else
      OpenWindow((WinResConfig.ArenaSettleWindow).name, UILayer.HUD, msg.temp)
    end
  end
)
    end
  end
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.OpenArenaUI = function(...)
  -- function num : 0_2 , upvalues : _ENV
  (Util.PreloadResource)({(((TableData.gTable).BaseFashionData)[(ActorData.GetFashionShow)()]).show_spine})
  OpenWindow((WinResConfig.ArenaWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.TryOpenRecordUI = function(...)
  -- function num : 0_3 , upvalues : _ENV
  (ArenaService.ReqArenaRecord)()
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.OpenRecordUI = function(...)
  -- function num : 0_4 , upvalues : _ENV
  OpenWindow((WinResConfig.ArenaRecordWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.TryOpenRankUI = function(...)
  -- function num : 0_5 , upvalues : _ENV
  (ArenaService.ReqArenaRank)()
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.OpenRankUI = function(...)
  -- function num : 0_6 , upvalues : _ENV
  OpenWindow((WinResConfig.ArenaRankWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.OpenRewardUI = function(type, ...)
  -- function num : 0_7 , upvalues : _ENV
  (ArenaData.InitRewardData)()
  OpenWindow((WinResConfig.ArenaRewardWindow).name, UILayer.HUD, type)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.PreChallengeCheck = function(op, ...)
  -- function num : 0_8 , upvalues : _ENV
  if (ArenaData.CheckSettle)() then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000041))
    UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_CHALLENGE_CD)
    return false
  end
  if (ArenaData.CheckOpen)() == false then
    if (ArenaData.CheckDayPass)() then
      (ArenaService.ReqArenaData)(op)
      return false
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(60000088))
      UIMgr:SendWindowMessage((WinResConfig.ArenaWindow).name, (WindowMsgEnum.Arena).E_MSG_REFRESH_CHALLENGE_CD)
      return false
    end
  end
  if (ArenaData.BaseData).surNum <= 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000435))
    return false
  end
  if (ArenaData.CheckCD)() then
    (MessageMgr.OpenCostResConfirmWindow)(60000042, ArenaData.ClearCDCost, function(...)
    -- function num : 0_8_0 , upvalues : _ENV
    (ArenaService.ReqArenaClearCDTime)()
  end
)
    return false
  end
  return true
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.TryRefreshRival = function(...)
  -- function num : 0_9 , upvalues : _ENV
  local interval = (LuaTime.GetTimeStamp)() - ArenaData.LastReqTimestamp
  if interval >= 0 and interval < ArenaData.RefreshIntervel then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000338, ArenaData.RefreshIntervel - interval))
    return false
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ArenaData.LastReqTimestamp = (LuaTime.GetTimeStamp)()
  ;
  (ArenaService.ReqArenaRefresh)()
  return true
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.ReqChallengePlayer = function(rank, isSmash, formation, ...)
  -- function num : 0_10 , upvalues : _ENV
  (ArenaService.ReqArenaFight)(rank, isSmash, formation)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.TryAcquireReward = function(rewardId, operType, type, ...)
  -- function num : 0_11 , upvalues : _ENV
  if (operType == ArenaRewardOperateType.All and type == ArenaRewardType.CareerReward and ArenaData.HaveAvaiableCareerReward == false) or operType == ArenaRewardOperateType.All and type == ArenaRewardType.DailyReward and ArenaData.HaveAvailableDailyReward == false then
    (MessageMgr.OpenSoloConfirmWindow)((PUtil.get)(60000031))
    return 
  end
  ;
  (ArenaService.ReqArenaReward)(rewardId, operType, type)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.SetRank = function(rank, uis, ...)
  -- function num : 0_12 , upvalues : _ENV
  if rank == 0 or rank == nil then
    (ArenaMgr.SetRankStatue)(uis, true)
  else
    ;
    (ArenaMgr.SetRankStatue)(uis, false)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.RankingTxt).text = "No." .. rank
  end
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.SetRankStatue = function(uis, show, ...)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (uis.RankingTxt).visible = not show
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if uis.NotListedImage ~= nil then
    (uis.NotListedImage).visible = show
  end
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.BeforeCloseFormation = function(formation, cb, isAttack, ...)
  -- function num : 0_14 , upvalues : _ENV
  if not isAttack then
    isAttack = false
  end
  ;
  (Util.BeforeCloseFormation)(formation, cb, function(...)
    -- function num : 0_14_0 , upvalues : isAttack, _ENV
    if isAttack then
      return (Util.CovertRemoteFormationToLocal)((ArenaData.BaseData).arenaCardGroups), 60000062
    else
      return (Util.CovertRemoteFormationToLocal)((ArenaData.BaseData).guardCardGroups), 60000039
    end
  end
, function(newFormation, ...)
    -- function num : 0_14_1 , upvalues : isAttack, _ENV
    if isAttack then
      (ArenaService.ReqArenaAttackCardGroups)(newFormation)
    else
      ;
      (ArenaService.ReqArenaGuardCardGroups)(newFormation)
    end
  end
)
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.TryReplayBattle = function(id, ...)
  -- function num : 0_15 , upvalues : _ENV
  local data = (ArenaData.GetBattleData)(id)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if data == nil then
    ArenaData.LastReqBattleDataType = ArenaReqBattleDataType.Replay
    ;
    (ArenaService.ReqBattleData)(id)
  else
    ;
    (ArenaMgr.ReplayBattle)(data)
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.TryShowBattleData = function(id, ...)
  -- function num : 0_16 , upvalues : _ENV
  local data = (ArenaData.GetBattleData)(id)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if data == nil then
    ArenaData.LastReqBattleDataType = ArenaReqBattleDataType.Data
    ;
    (ArenaService.ReqBattleData)(id)
  else
    ;
    (ArenaMgr.ShowBattleData)(data)
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.AfterRecvBattleData = function(data, ...)
  -- function num : 0_17 , upvalues : _ENV
  (ArenaData.UpdateBattleData)(data)
  if ArenaData.LastReqBattleDataType == ArenaReqBattleDataType.Replay then
    (ArenaMgr.ReplayBattle)(data)
  else
    ;
    (ArenaMgr.ShowBattleData)(data)
  end
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.ReplayBattle = function(data, ...)
  -- function num : 0_18 , upvalues : _ENV
  loge("ReplayBattle")
  ;
  (ArenaData.SaveFightResult)()
  ;
  (BattleService.OnBattle_BattleCompleteData)(data, true)
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

ArenaMgr.ShowBattleData = function(data, ...)
  -- function num : 0_19 , upvalues : _ENV
  (CommonWinMgr.OpenBattleDataWindow)(data.challengeSummarizeData)
end


