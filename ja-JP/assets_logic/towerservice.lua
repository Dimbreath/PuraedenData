-- params : ...
-- function num : 0 , upvalues : _ENV
TowerService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

TowerService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResTowerInit, TowerService.RecvTowerData)
  ;
  (Net.AddListener)((Proto.MsgName).ResInTower, TowerService.RecvEnterTower)
  ;
  (Net.AddListener)((Proto.MsgName).ResSettleTower, TowerService.RecvSettleTower)
  ;
  (Net.AddListener)((Proto.MsgName).ResInTowerEncounter, TowerService.RecvInTowerEncounter)
  ;
  (Net.AddListener)((Proto.MsgName).ResEmbattle, TowerService.RecvTowerCardGroups)
  ;
  (Net.AddListener)((Proto.MsgName).ResSettleEncounter, TowerService.RecvSettleEncounter)
  ;
  (Net.AddListener)((Proto.MsgName).ResEncounterBattleEmba, TowerService.RecvEncounterBattleEmba)
  ;
  (Net.AddListener)((Proto.MsgName).ResCancelEncounter, TowerService.RecvCancelEncounter)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

TowerService.ReqTowerData = function(isOpen, ...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqTowerInit, m, (Proto.MsgName).ResTowerInit)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

TowerService.RecvTowerData = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (TowerMgr.RecvTowerData)(msg)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

TowerService.ReqEnterTower = function(id, formation, isSweep, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.towerStageId = id
  m.cardInfo = formation
  m.isSweep = isSweep
  if isSweep then
    (Net.Send)((Proto.MsgName).ReqInTower, m, (Proto.MsgName).ResInTower)
  else
    ;
    (Net.Send)((Proto.MsgName).ReqInTower, m, (Proto.MsgName).InitBattleData)
  end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

TowerService.RecvEnterTower = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  TowerData.LastReqStageId = 0
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  TowerData.FormationInfo = msg.cardInfo
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

TowerService.ReqSettleTower = function(data, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.battleCompleteData = data
  ;
  (Net.Send)((Proto.MsgName).ReqSettleTower, m, (Proto.MsgName).ResSettleTower, function(...)
    -- function num : 0_5_0 , upvalues : _ENV, data
    (TowerService.ReqSettleTower)(data)
  end
)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

TowerService.RecvSettleTower = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  if msg.isSuccess then
    local stageId = TowerData.LastReqStageId
    if stageId == 0 then
      stageId = (msg.towerStage).towerStageId
    end
    ;
    (TowerData.UpdateTowerData)(msg)
    ;
    (TowerMgr.HandleReward)(msg, stageId)
    local config = ((TableData.gTable).BaseTowerStageData)[stageId]
    local cost = split(config.cost, ":")
    if (ActorData.GetGoodsCount)(tonumber(cost[2]), tonumber(cost[1])) < tonumber(cost[3]) then
      (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureWindow).name, RedDotComID.Adventure_Tower)
    end
  else
    do
      do
        local m = {}
        m.BattleType = (ProtoEnum.E_BATTLE_TYPE).TOWER
        ;
        (CommonWinMgr.OpenBattleFailConvergeWindow)(m)
        -- DECOMPILER ERROR at PC67: Confused about usage of register: R1 in 'UnsetPending'

        if TowerData.HaveBounsLevel ~= msg.triggerEncounter and msg.triggerEncounter then
          TowerData.PopUpBounsLevel = true
        end
        -- DECOMPILER ERROR at PC70: Confused about usage of register: R1 in 'UnsetPending'

        TowerData.HaveBounsLevel = msg.triggerEncounter
        loge("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~triggerEncounter:" .. tostring(msg.triggerEncounter))
        UIMgr:SendWindowMessage((WinResConfig.TowerWindow).name, (WindowMsgEnum.Tower).E_MSG_REFRESH_BOUNS_STATUS)
      end
    end
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

TowerService.ReqTowerCardGroups = function(formation, ...)
  -- function num : 0_7 , upvalues : _ENV
  local m = {}
  m.type = (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_TOWER
  m.cardInfo = (Util.CovertLoaclFormationToRemote)(formation)
  ;
  (Net.Send)((Proto.MsgName).ReqEmbattle, m, (Proto.MsgName).ResEmbattle)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

TowerService.RecvTowerCardGroups = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if msg.type == (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_TOWER then
    TowerData.FormationInfo = msg.cardInfo
    ;
    (TowerData.InitLuckyInfo)()
  else
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

    if msg.type == (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_ENCOUNTER then
      (TowerData.BounsLevelData).myCards = msg.cardInfo
      UIMgr:SendWindowMessage((WinResConfig.TowerBounsLevelWindow).name, (WindowMsgEnum.Tower).E_MSG_REFRESH_SELF_FC)
    end
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

TowerService.ReqEncounterBattleEmba = function(...)
  -- function num : 0_9 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqEncounterBattleEmba, m, (Proto.MsgName).ResEncounterBattleEmba)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

TowerService.RecvEncounterBattleEmba = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  TowerData.BounsLevelData = msg
  ;
  (TowerMgr.OpenBounsLevel)()
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

TowerService.ReqInTowerEncounter = function(formation, ...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  m.cardInfo = formation
  ;
  (Net.Send)((Proto.MsgName).ReqInTowerEncounter, m, (Proto.MsgName).InitBattleData)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

TowerService.RecvInTowerEncounter = function(msg, ...)
  -- function num : 0_12
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

TowerService.ReqSettleEncounter = function(data, ...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  m.battleCompleteData = data
  ;
  (Net.Send)((Proto.MsgName).ReqSettleEncounter, m, (Proto.MsgName).ResSettleEncounter, function(...)
    -- function num : 0_13_0 , upvalues : _ENV, data
    (TowerService.ReqSettleEncounter)(data)
  end
)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

TowerService.RecvSettleEncounter = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  TowerData.HaveBounsLevel = not msg.success
  if msg.success then
    local m = {}
    m.BattleType = (ProtoEnum.E_BATTLE_TYPE).TOWER_ENCOUNTER
    m.cardInfo = (TowerData.BounsLevelData).myCards
    m.BasicGoods = {}
    for k,v in ipairs(msg.goodsLists) do
      local item = {}
      item.id = v.id
      item.Num = v.value
      item.Type = v.type
      item.isGet = false
      ;
      (table.insert)(m.BasicGoods, item)
    end
    local btn2 = {}
    btn2.btnTxt = (PUtil.get)(20000016)
    btn2.fun = function(...)
    -- function num : 0_14_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.TowerBounsLevelWindow).name, true, true)
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_14_0_0 , upvalues : _ENV
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
      do
        local m = {}
        m.BattleType = (ProtoEnum.E_BATTLE_TYPE).TOWER_ENCOUNTER
        ;
        (CommonWinMgr.OpenBattleFailConvergeWindow)(m)
        -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

        if TowerData.HaveBounsLevel == false then
          TowerData.BounsLevelData = nil
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

TowerService.ReqBounsCardGroups = function(formation, ...)
  -- function num : 0_15 , upvalues : _ENV
  local m = {}
  m.type = (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_ENCOUNTER
  m.cardInfo = (Util.CovertLoaclFormationToRemote)(formation)
  ;
  (Net.Send)((Proto.MsgName).ReqEmbattle, m, (Proto.MsgName).ResEmbattle)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

TowerService.ReqCancelEncounter = function(...)
  -- function num : 0_16 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqCancelEncounter, m, (Proto.MsgName).ResCancelEncounter)
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

TowerService.RecvCancelEncounter = function(msg, ...)
  -- function num : 0_17 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  TowerData.HaveBounsLevel = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  TowerData.BounsLevelData = nil
  UIMgr:SendWindowMessage((WinResConfig.TowerWindow).name, (WindowMsgEnum.Tower).E_MSG_REFRESH_BOUNS_STATUS)
end

;
(TowerService.Init)()

