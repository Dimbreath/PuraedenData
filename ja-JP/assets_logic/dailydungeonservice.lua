-- params : ...
-- function num : 0 , upvalues : _ENV
DailyDungeonService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResTrialInit, DailyDungeonService.OnResTrialInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResEmbattle, DailyDungeonService.OnResEmbattle)
  ;
  (Net.AddListener)((Proto.MsgName).ResInTrial, DailyDungeonService.OnResInTrial)
  ;
  (Net.AddListener)((Proto.MsgName).ResSettleTrial, DailyDungeonService.OnResSettleTrial)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonService.ReqInitData = function(initCallBack, ...)
  -- function num : 0_1 , upvalues : _ENV
  local t = {}
  ;
  (Net.Send)((Proto.MsgName).ReqTrialInit, t, (Proto.MsgName).ResTrialInit)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  DailyDungeonService.initCallBack = initCallBack
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonService.ReqInTrial = function(cardInfo, id, isSweep, ...)
  -- function num : 0_2 , upvalues : _ENV
  local t = {}
  t.cardInfo = cardInfo
  t.id = id
  t.isSweep = isSweep
  ;
  (Net.Send)((Proto.MsgName).ReqInTrial, t, (Proto.MsgName).ResInTrial)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonService.ReqSettleTrial = function(battleCompleteData, ...)
  -- function num : 0_3 , upvalues : _ENV
  local t = {}
  t.battleCompleteData = battleCompleteData
  ;
  (Net.Send)((Proto.MsgName).ReqSettleTrial, t, (Proto.MsgName).ResSettleTrial, function(...)
    -- function num : 0_3_0 , upvalues : _ENV, battleCompleteData
    (DailyDungeonService.ReqSettleTrial)(battleCompleteData)
  end
)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonService.ReqSweepTrial = function(trialIdList, num, ...)
  -- function num : 0_4 , upvalues : _ENV
  local t = {}
  t.trialId = trialIdList
  t.num = num
  ;
  (Net.Send)((Proto.MsgName).ReqSweepTrial, t, (Proto.MsgName).ResSettleTrial)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonService.OnResTrialInit = function(msg, ...)
  -- function num : 0_5 , upvalues : _ENV
  PrintTable(msg, "", "收到每日副本初始化信息:")
  ;
  (DailyDungeonData.InitTrialData)(msg)
  local initCallBack = DailyDungeonService.initCallBack
  if initCallBack then
    initCallBack()
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

    DailyDungeonService.initCallBack = nil
  else
    ;
    (DailyDungeonMgr.OpenDailyDungeonChapterList)()
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonService.OnResEmbattle = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  if msg then
    local E_EMBATTLE_TYPE = ProtoEnum.E_EMBATTLE_TYPE
    if msg.type == E_EMBATTLE_TYPE.EMBATTLE_EXP or msg.type == E_EMBATTLE_TYPE.EMBATTLE_EQUIPEXP or msg.type == E_EMBATTLE_TYPE.EMBATTLE_GOLD then
      PrintTable(msg, "", "收到每日副本修改布阵:")
      ;
      (DailyDungeonData.UpdateSelfCardInfo)(msg)
    end
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonService.OnResInTrial = function(msg, ...)
  -- function num : 0_7 , upvalues : _ENV
  PrintTable(msg, "", "收到每日副本进入战斗:")
  local into = msg.into
  if into == true then
    local cardInfo = msg.cardInfo
    if cardInfo then
      local type = DailyDungeonMgr.curSelectTrialType
      local preTrialData = (DailyDungeonData.GetTrialDataByType)(type)
      if preTrialData then
        preTrialData.cardInfo = cardInfo
      end
    end
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonService.OnResSettleTrial = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  PrintTable(msg, "", "收到每日副本结算信息:")
  local sweep = msg.sweep
  msg = msg.settleTrial
  if msg then
    local stageId, isOpen = nil, nil
    if sweep == false then
      stageId = BattleData.stageId
      isOpen = (DailyDungeonData.IsNextStageOpen)(stageId)
    end
    for _,oneSettleTrial in ipairs(msg) do
      (DailyDungeonData.UpdateTrialData)(oneSettleTrial)
      if sweep == false and isOpen == false then
        isOpen = (DailyDungeonData.IsNextStageOpen)(stageId)
      end
    end
    if isOpen == true then
      do
        UIMgr:SendWindowMessage((WinResConfig.DailyDungeonDifficultyWindow).name, (WindowMsgEnum.DailyDungeonDifficultyWindow).E_MSG_UPDATE_CHALLENGE)
        if (DailyDungeonService.CheckRedDotIsDispose)() then
          (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureWindow).name, RedDotComID.Adventure_Daily)
        end
        if sweep == true then
          local items = {}
          for _,v in ipairs(msg) do
            local trialDrop = v.trialDrop
            for _,good in ipairs(trialDrop) do
              (table.insert)(items, {Type = good.type, id = good.id, Num = good.value})
            end
          end
          UIMgr:CloseWindow((WinResConfig.DailyDungeonSweepWindow).name)
          if #items > 0 then
            (MessageMgr.OpenRewardShowWindow)(items)
          end
        else
          do
            ;
            (DailyDungeonMgr.OpenDailyDungeonBattleWindow)(msg[1])
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonService.CheckRedDotIsDispose = function(...)
  -- function num : 0_9 , upvalues : _ENV
  for _,v in pairs(DailyDungeonData.trialDataTable) do
    local satisfy = false
    if (v.trial).type == PlayType.CoinDungeon and (FunctionControlMgr.GetFunctionState)(ControlID.Daily_Gold, false) then
      satisfy = true
    else
      if (v.trial).type == PlayType.RoleExpDungeon and (FunctionControlMgr.GetFunctionState)(ControlID.Daily_Medical, false) then
        satisfy = true
      else
        if (v.trial).type == PlayType.EquipmentExpDungeon and (FunctionControlMgr.GetFunctionState)(ControlID.Daily_Crystal, false) then
          satisfy = true
        end
      end
    end
    if (v.trial).num > 0 and satisfy then
      return false
    end
  end
  return true
end

;
(DailyDungeonService.Init)()

