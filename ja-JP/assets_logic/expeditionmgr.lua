-- params : ...
-- function num : 0 , upvalues : _ENV
ExpeditionMgr = {}
-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionMgr.StageType = {General = 1, Hard = 2, Dead = 3, Altar = 4, Merchant = 5, Treasure = 6}
-- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionMgr.Direction = {Left = 1, Right = 2}
-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionMgr.BuffType = {Addition = 0, SingleHeal = 1, EntireHeal = 2, SingleResurgence = 3}
-- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionMgr.CardState = {NoFight = -1, Normal = 1, Tired = 2, Dead = 3}
local self = ExpeditionMgr
self.ExpeditionData = nil
self.CanClick = true
self.externalShopStateID = {}
self.guideTips = nil
-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.SetExpeditionData = function(data, ...)
  -- function num : 0_0 , upvalues : self, _ENV
  self.ExpeditionData = data
  ;
  (ExpeditionMgr.GetShopStageType)()
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetExpeditionChangeFc = function(...)
  -- function num : 0_1 , upvalues : self
  if self.ExpeditionData then
    return (self.ExpeditionData).changeFc
  end
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetShopStageType = function(...)
  -- function num : 0_2 , upvalues : self, _ENV
  self.externalShopStateID = {}
  for _,v in ipairs((self.ExpeditionData).exBuy) do
    if not (ExpeditionMgr.IsContainKey)(self.externalShopStateID, v.stageId) then
      (table.insert)(self.externalShopStateID, v.stageId)
    end
  end
  ;
  (table.sort)(self.externalShopStateID, function(a, b, ...)
    -- function num : 0_2_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetExternalShop = function(...)
  -- function num : 0_3 , upvalues : self
  return self.externalShopStateID
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.IsContainKey = function(mTable, Value, ...)
  -- function num : 0_4 , upvalues : _ENV
  for _,v in pairs(mTable) do
    if v == Value then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetExpeditionSelfMaxFc = function(...)
  -- function num : 0_5 , upvalues : self
  if self.ExpeditionData then
    return (self.ExpeditionData).selfMaxFc
  end
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetCurrentExpeditionId = function(...)
  -- function num : 0_6 , upvalues : self
  if self.ExpeditionData then
    return (self.ExpeditionData).expeditionId
  end
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetCurrentStage = function(...)
  -- function num : 0_7 , upvalues : self
  if self.ExpeditionData then
    return (self.ExpeditionData).stageId
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetSweepDander = function(...)
  -- function num : 0_8 , upvalues : self
  if self.ExpeditionData then
    return (self.ExpeditionData).sweepDander
  end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetExpeditionNum = function(expeditionID, ...)
  -- function num : 0_9 , upvalues : _ENV
  local ExpeditionData = (TableData.gTable).BaseExpeditionData
  local Data = {}
  for _,v in pairs(ExpeditionData) do
    (table.insert)(Data, v)
  end
  ;
  (table.sort)(Data, function(a, b, ...)
    -- function num : 0_9_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(Data) do
    if v.id == expeditionID then
      return i
    end
  end
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetStageNum = function(stageId, ...)
  -- function num : 0_10 , upvalues : _ENV
  local eData = (ExpeditionMgr.GetExpeditionPoints)((ExpeditionMgr.GetCurrentExpeditionId)())
  for i,v in ipairs(eData) do
    if v.id == tonumber(stageId) then
      return i
    end
  end
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetCurrentEndStage = function(expeditionId, ...)
  -- function num : 0_11 , upvalues : _ENV
  local stageS = (ExpeditionMgr.GetExpeditionPoints)(expeditionId)
  for _,v in ipairs(stageS) do
    if v.next == 0 then
      return v.id
    end
  end
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetMaxFight = function(...)
  -- function num : 0_12 , upvalues : self
  return (self.ExpeditionData).cardMaxNum
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetAlreadyFightCard = function(...)
  -- function num : 0_13 , upvalues : self
  return (self.ExpeditionData).yetCardState
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetEnemyFormation = function(...)
  -- function num : 0_14 , upvalues : _ENV
  local formation = {}
  for i = 1, 6 do
    local data = (ExpeditionMgr.GetRivalDataByPos)(i)
    if data and data.state ~= (ExpeditionMgr.CardState).Dead and data.supHp > 0 then
      local EnemyData = {}
      EnemyData.fashionId = data.fashionId
      EnemyData.spd = data.speed
      EnemyData.fc = data.fc
      formation[i] = EnemyData
    end
  end
  return formation
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.ChapterSortNum = function(number, ...)
  -- function num : 0_15 , upvalues : self
  if number then
    self.ChapterSort = number
  else
    return self.ChapterSort
  end
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.SweepNum = function(number, ...)
  -- function num : 0_16 , upvalues : self
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  if number then
    (self.ExpeditionData).sweepNum = number
  else
    return (self.ExpeditionData).sweepNum
  end
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.ExpeditionBuff = function(buffs, ...)
  -- function num : 0_17 , upvalues : self
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  if buffs then
    (self.ExpeditionData).buffIds = buffs
  else
    return (self.ExpeditionData).buffIds
  end
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.ExpeditionAltarData = function(data, ...)
  -- function num : 0_18 , upvalues : _ENV, self
  if data then
    local buffs = {}
    for _,v in ipairs(data) do
      buffs[v.value] = v.id
    end
    self.AltarData = buffs
  else
    do
      do return self.AltarData end
    end
  end
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetSpecialMerchantData = function(id, ...)
  -- function num : 0_19 , upvalues : _ENV, self
  local mTable = {}
  for _,v in ipairs((self.ExpeditionData).exBuy) do
    if v.stageId == id then
      (table.insert)(mTable, v)
    end
  end
  ;
  (table.sort)(mTable, function(a, b, ...)
    -- function num : 0_19_0
    do return a.shopType < b.shopType end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return mTable
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.RefreshSpecialMerchantData = function(data, ...)
  -- function num : 0_20 , upvalues : _ENV, self
  for _,v in ipairs((self.ExpeditionData).exBuy) do
    if v.stageId == data.stageId and v.shopType == data.shopType then
      v.buyNum = data.buyNum
      v.totalNum = data.totalNum
    end
  end
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.ExpeditionMerchantData = function(data, ...)
  -- function num : 0_21 , upvalues : self
  if data then
    self.MerchantData = data
  else
    return self.MerchantData
  end
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.RefreshMerchantData = function(data, ...)
  -- function num : 0_22 , upvalues : _ENV, self
  for _,v in ipairs(self.MerchantData) do
    if v.shopType == data.shopType then
      v.buyNum = data.buyNum
      v.totalNum = data.totalNum
    end
  end
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetRivalDataByPos = function(pos, ...)
  -- function num : 0_23 , upvalues : self, _ENV
  local dataS = (self.ExpeditionData).rivalCard
  for _,v in ipairs(dataS) do
    if v.pos == pos then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.ExpeditionIsChallenging = function(data, ...)
  -- function num : 0_24 , upvalues : self
  if data ~= nil then
    self.IsInitWindow = data
  else
    return self.IsInitWindow
  end
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetExpeditionPoints = function(expeditionId, ...)
  -- function num : 0_25 , upvalues : _ENV
  local ExpeditionData = (TableData.gTable).BaseExpeditionStageData
  local points = {}
  for _,v in pairs(ExpeditionData) do
    if v.expedition_id == tonumber(expeditionId) then
      (table.insert)(points, v)
    end
  end
  ;
  (table.sort)(points, function(a, b, ...)
    -- function num : 0_25_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return points
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.ExpeditionStageIsPass = function(stageID, ...)
  -- function num : 0_26 , upvalues : _ENV
  local eData = (ExpeditionMgr.GetExpeditionPoints)((ExpeditionMgr.GetCurrentExpeditionId)())
  local curStage = (ExpeditionMgr.GetCurrentStage)()
  if curStage == -1 then
    return true
  end
  for _,v in ipairs(eData) do
    if v.id == stageID and stageID < curStage then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.ExpeditionStageCanChallenge = function(stageID, ...)
  -- function num : 0_27 , upvalues : _ENV
  local curStage = (ExpeditionMgr.GetCurrentStage)()
  do return curStage == stageID end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.ExpeditionStageIsFight = function(stageID, ...)
  -- function num : 0_28 , upvalues : _ENV
  local ExpeditionData = ((TableData.gTable).BaseExpeditionStageData)[stageID]
  do return ExpeditionData.type == (ExpeditionMgr.StageType).General or ExpeditionData.type == (ExpeditionMgr.StageType).Hard or ExpeditionData.type == (ExpeditionMgr.StageType).Dead end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.OnClickChallenge = function(stageID, ...)
  -- function num : 0_29 , upvalues : _ENV
  local ExpeditionData = ((TableData.gTable).BaseExpeditionStageData)[stageID]
  local btnData = {}
  btnData.btnTxt = (PUtil.get)(20000021)
  btnData.fun = function(cards, ...)
    -- function num : 0_29_0 , upvalues : _ENV, stageID
    (ExpeditionService.OnReqIntoExpedition)(stageID, cards)
  end

  local externalData = {}
  externalData.buff = tonumber(ExpeditionData.buff_ids)
  externalData.maxFight = (ExpeditionMgr.GetMaxFight)()
  externalData.cardState = (ExpeditionMgr.GetAlreadyFightCard)()
  externalData.sweepDander = (ExpeditionMgr.GetSweepDander)() or 0
  local formationData = {}
  formationData.formationType = FormationType.Expedition
  formationData.otherPlayerList = (ExpeditionMgr.GetEnemyFormation)()
  formationData.myselfList = (ExpeditionMgr.GetSelfFormation)()
  formationData.BtnData = btnData
  formationData.stageId = stageID
  formationData.ExternalData = externalData
  formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).EXPEDITION
  formationData.closeFun = function(...)
    -- function num : 0_29_1 , upvalues : _ENV
    (ExpeditionMgr.ExpeditionIsChallenging)(false)
  end

  formationData.backFun = function(...)
    -- function num : 0_29_2 , upvalues : _ENV
    (ExpeditionMgr.ExpeditionIsChallenging)(true)
    ;
    (ExpeditionMgr.SetSettleResult)(false)
  end

  UIMgr:CloseWindow((WinResConfig.ExpeditionDetailWindow).name)
  ;
  (MessageMgr.OpenFormationWindow)(formationData)
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetSelfFormation = function(...)
  -- function num : 0_30 , upvalues : self, _ENV
  local formation = {}
  local dataS = (self.ExpeditionData).battleCardState
  for _,v in ipairs(dataS) do
    if v.cardState == (ExpeditionMgr.CardState).Normal then
      formation[v.pos] = v.cardId
      if v.pos > 6 then
        loge("此时刚总应该出问题了")
      end
    end
  end
  return formation
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.ShowSettleResult = function(...)
  -- function num : 0_31 , upvalues : self
  return self.SettleResult
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.SetSettleResult = function(data, ...)
  -- function num : 0_32 , upvalues : self
  self.SettleResult = data
end

-- DECOMPILER ERROR at PC137: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.ShowSettleType = function(msg, ...)
  -- function num : 0_33 , upvalues : _ENV, self
  local success = msg.success
  local reward = msg.reward
  local isSweep = msg.isSweep
  local stageId = (ExpeditionMgr.GetCurrentStage)()
  local ExpeditionData = ((TableData.gTable).BaseExpeditionStageData)[stageId]
  if success and ExpeditionData.next == 0 and (Util.StringIsNullOrEmpty)((Util.GetPlayerSetting)(PlayerPrefsKeyName.EXPEDITION_PASS .. tostring(ExpeditionData.expedition_id))) then
    self.guideTips = (((TableData.gTable).BaseExpeditionData)[ExpeditionData.expedition_id]).name
    ;
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.EXPEDITION_PASS .. tostring(ExpeditionData.expedition_id), "Pass")
  end
  if (ExpeditionMgr.ExpeditionStageIsFight)(stageId) then
    self.SettleResult = success
    if isSweep then
      (ExpeditionMgr.SetExpeditionData)(msg.expedition)
      ;
      (MessageMgr.OpenRewardByGoods)(reward, function(...)
    -- function num : 0_33_0 , upvalues : _ENV, msg
    UIMgr:SendWindowMessage((WinResConfig.ExpeditionWindow).name, (WindowMsgEnum.ExpeditionWindow).SWEEP_SHOW, (msg.expedition).stageId)
  end
)
      return 
    end
    if success then
      (ExpeditionMgr.OpenExpeditionSettle)(ExpeditionData, reward)
    else
      local m = {}
      m.BattleType = (ProtoEnum.E_BATTLE_TYPE).EXPEDITION
      local btn = {}
      btn.btnTxt = (PUtil.get)(60000004)
      btn.fun = function(...)
    -- function num : 0_33_1 , upvalues : _ENV
    ld("Battle", function(...)
      -- function num : 0_33_1_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
  end

      m.btn2 = btn
      ;
      (CommonWinMgr.OpenBattleFailConvergeWindow)(m)
    end
    do
      ;
      (ExpeditionMgr.SetExpeditionData)(msg.expedition)
      if success then
        loge("关卡结算")
        ;
        (ExpeditionMgr.SetExpeditionData)(msg.expedition)
        UIMgr:SendWindowMessage((WinResConfig.ExpeditionWindow).name, (WindowMsgEnum.ExpeditionWindow).GOTO_NEXT_POINT, stageId)
        if ExpeditionData.type == (ExpeditionMgr.StageType).Treasure then
          (MessageMgr.OpenRewardByGoods)(msg.reward)
        end
        if ExpeditionData.next == 0 then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000117))
        end
      else
        ;
        (ExpeditionMgr.SetExpeditionData)(msg.expedition)
        UIMgr:SendWindowMessage((WinResConfig.ExpeditionWindow).name, (WindowMsgEnum.ExpeditionWindow).GOTO_BACK_POINT)
      end
    end
  end
end

-- DECOMPILER ERROR at PC140: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.ExpeditionCanClick = function(value, ...)
  -- function num : 0_34 , upvalues : self
  if value ~= nil then
    self.CanClick = value
  else
    return self.CanClick
  end
end

-- DECOMPILER ERROR at PC143: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.OpenExpeditionSettle = function(ExpeditionData, reward, ...)
  -- function num : 0_35 , upvalues : _ENV
  local m = {}
  m.BattleType = (ProtoEnum.E_BATTLE_TYPE).EXPEDITION
  m.CardAddIntimacy = ExpeditionData.card_intimacy
  if ExpeditionData.type == (ExpeditionMgr.StageType).Hard then
    m.SpecialTips = (PUtil.get)(20000114)
  else
    if ExpeditionData.type == (ExpeditionMgr.StageType).Dead then
      m.SpecialTips = (PUtil.get)(20000115)
    end
  end
  m.BasicGoods = (Util.GoodsObjectToItemDataModel)(reward)
  local btn2 = {}
  btn2.btnTxt = (PUtil.get)(20000016)
  btn2.fun = function(...)
    -- function num : 0_35_0 , upvalues : _ENV, ExpeditionData
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_35_0_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
      UIMgr:CloseWindow((WinResConfig.BattleWinConvergeWindow).name)
      UIMgr:SetOnShownComplete((WinResConfig.ExpeditionWindow).name, function(...)
      -- function num : 0_35_0_1 , upvalues : ExpeditionData, _ENV
      if ExpeditionData.next == 0 then
        (SimpleTimer.setTimeout)(0.2, function(...)
        -- function num : 0_35_0_1_0 , upvalues : _ENV
        (MessageMgr.SendCenterTips)((PUtil.get)(20000117))
      end
)
      end
    end
)
    else
      UIMgr:CloseWindow((WinResConfig.BattleWinConvergeWindow).name)
    end
  end

  m.btn2 = btn2
  ;
  (CommonWinMgr.OpenBattleSettleConvergeWindow)(m)
end

-- DECOMPILER ERROR at PC146: Confused about usage of register: R1 in 'UnsetPending'

ExpeditionMgr.GetShopDataConfig = function(type, times, ...)
  -- function num : 0_36 , upvalues : _ENV
  times = times + 1
  local ShopData = (TableData.gTable).BaseExpeditionShopData
  for _,v in pairs(ShopData) do
    if v.type == type and v.start <= times and times <= v.finish then
      return v
    end
  end
  times = times - 1
  for _,v in pairs(ShopData) do
    if v.type == type and v.start <= times and times <= v.finish then
      return v
    end
  end
end


