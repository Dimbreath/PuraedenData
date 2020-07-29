-- params : ...
-- function num : 0 , upvalues : _ENV
ExpeditionService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResExpedition, ExpeditionService.ResExpeditionData)
  ;
  (Net.AddListener)((Proto.MsgName).ResInExpedition, ExpeditionService.ResIntoExpedition)
  ;
  (Net.AddListener)((Proto.MsgName).ResSettleExpedition, ExpeditionService.ResSettleExpedition)
  ;
  (Net.AddListener)((Proto.MsgName).ResShopExpeditionBuy, ExpeditionService.ResBuyExpedition)
  ;
  (Net.AddListener)((Proto.MsgName).ResShopExpedition, ExpeditionService.ResShopExpedition)
  ;
  (Net.AddListener)((Proto.MsgName).ResBuffExpedition, ExpeditionService.ResBuffExpedition)
  ;
  (Net.AddListener)((Proto.MsgName).ResDrawBuff, ExpeditionService.ResDrawBuff)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.OnReqExpeditionData = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqExpedition, m, (Proto.MsgName).ResExpedition)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.ResExpeditionData = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  if (msg.expedition).expeditionId == 0 then
    OpenWindow((WinResConfig.ExpeditionChoiceWindow).name, UILayer.HUD, msg.expeditionData)
  else
    ;
    (ExpeditionMgr.SetExpeditionData)(msg.expedition)
    OpenWindow((WinResConfig.ExpeditionWindow).name, UILayer.HUD)
    ;
    (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureWindow).name, RedDotComID.Adventure_Expedition)
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.OnReqSetExpedition = function(ExpeditionID, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.expeditionId = ExpeditionID
  ;
  (Net.Send)((Proto.MsgName).ReqSetExpedition, m, (Proto.MsgName).ResExpedition)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.OnReqIntoExpedition = function(StageId, cards, ...)
  -- function num : 0_4 , upvalues : _ENV
  local m = {}
  m.stageId = StageId
  do
    if cards then
      local cardInfo = {}
      for i = 1, 6 do
        local common = {}
        if cards[i] then
          common.id = cards[i]
        else
          common.id = 0
        end
        common.value = i
        ;
        (table.insert)(cardInfo, common)
      end
      m.cardInfo = cardInfo
    end
    local StageData = ((TableData.gTable).BaseExpeditionStageData)[StageId]
    if StageData.type == (ExpeditionMgr.StageType).Altar then
      (Net.Send)((Proto.MsgName).ReqInExpedition, m, (Proto.MsgName).ResBuffExpedition)
    else
      if StageData.type == (ExpeditionMgr.StageType).Merchant then
        (Net.Send)((Proto.MsgName).ReqInExpedition, m, (Proto.MsgName).ResShopExpedition)
      else
        ;
        (Net.Send)((Proto.MsgName).ReqInExpedition, m, (Proto.MsgName).InitBattleData)
      end
    end
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.ResIntoExpedition = function(msg, ...)
  -- function num : 0_5 , upvalues : _ENV
  if not msg.into then
    return 
  end
  ;
  (ExpeditionMgr.SweepNum)(msg.sweepNum)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.ResShopExpedition = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  (ExpeditionMgr.ExpeditionMerchantData)(msg.exBuy)
  OpenWindow((WinResConfig.ExpeditionEventWindow).name, UILayer.HUD, msg.stageId)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.ResBuffExpedition = function(msg, ...)
  -- function num : 0_7 , upvalues : _ENV
  (ExpeditionMgr.ExpeditionAltarData)(msg.buffs)
  OpenWindow((WinResConfig.ExpeditionEventWindow).name, UILayer.HUD, msg.stageId)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.OnReqDrawBuff = function(stageId, buffId, cardId, ...)
  -- function num : 0_8 , upvalues : _ENV
  local ExpeBuff = {}
  ExpeBuff.buffId = buffId
  if cardId then
    ExpeBuff.cardId = cardId
  else
    ExpeBuff.cardId = 0
  end
  local m = {}
  m.stageId = stageId
  m.expeBuff = ExpeBuff
  ;
  (Net.Send)((Proto.MsgName).ReqDrawBuff, m, (Proto.MsgName).ResDrawBuff)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.ResDrawBuff = function(msg, ...)
  -- function num : 0_9 , upvalues : _ENV
  (ExpeditionMgr.SetExpeditionData)(msg.expedition)
  local buff = ((TableData.gTable).BaseBuffPreBattleData)[tonumber((msg.expeBuff).buffId)]
  if buff.type == (ExpeditionMgr.BuffType).Addition then
    UIMgr:SendWindowMessage((WinResConfig.ExpeditionWindow).name, (WindowMsgEnum.ExpeditionWindow).PLAY_BUFF_EFFECT, msg.stageId)
  else
    if buff.type == (ExpeditionMgr.BuffType).SingleHeal then
      UIMgr:SendWindowMessage((WinResConfig.ExpeditionEventWindow).name, (WindowMsgEnum.ExpeditionEventWindow).SINGLE_HEAL, msg.expeBuff)
    else
      if buff.type == (ExpeditionMgr.BuffType).SingleResurgence then
        UIMgr:SendWindowMessage((WinResConfig.ExpeditionEventWindow).name, (WindowMsgEnum.ExpeditionEventWindow).SINGLE_REGAIN, msg.expeBuff)
      else
        if buff.type == (ExpeditionMgr.BuffType).EntireHeal then
          UIMgr:SendWindowMessage((WinResConfig.ExpeditionEventWindow).name, (WindowMsgEnum.ExpeditionEventWindow).ENTIRE_HEAL, msg.expeBuff)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.OnReqSettleExpedition = function(stageId, battleData, ...)
  -- function num : 0_10 , upvalues : _ENV
  local m = {}
  m.stageId = stageId
  m.battleCompleteData = battleData
  ;
  (Net.Send)((Proto.MsgName).ReqSettleExpedition, m, (Proto.MsgName).ResSettleExpedition, function(...)
    -- function num : 0_10_0 , upvalues : _ENV, stageId, battleData
    (ExpeditionService.OnReqSettleExpedition)(stageId, battleData)
  end
)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.ResSettleExpedition = function(msg, ...)
  -- function num : 0_11 , upvalues : _ENV
  (ExpeditionMgr.ShowSettleType)(msg)
  UIMgr:SendWindowMessage((WinResConfig.ExpeditionWindow).name, (WindowMsgEnum.ExpeditionWindow).CHANGE_SWEEP_TIMES)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.OnReqBuyExpedition = function(stageId, shopId, ...)
  -- function num : 0_12 , upvalues : _ENV
  local m = {}
  m.stageId = stageId
  m.shopId = shopId
  ;
  (Net.Send)((Proto.MsgName).ReqShopExpeditionBuy, m, (Proto.MsgName).ResShopExpeditionBuy)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

ExpeditionService.ResBuyExpedition = function(msg, ...)
  -- function num : 0_13 , upvalues : _ENV
  local items = msg.goodsObjs
  for _,v in ipairs(items) do
    local itemData, DataType = (Util.GetConfigDataByID)(v.id)
    do
      local item = {}
      item.id = v.id
      item.Num = v.value
      item.Type = v.type
      if DataType == PropType.ITEM and itemData.type == PropItemType.CHARACTER_DEBRIS then
        (SimpleTimer.setTimeout)(0.5, function(...)
    -- function num : 0_13_0 , upvalues : _ENV, item
    (MessageMgr.OpenRewardShowWindow)({item})
  end
)
      else
        ;
        (MessageMgr.OpenItemBuyTipsWindow)({item})
      end
    end
  end
  if (msg.exBuy).stageId == (ExpeditionMgr.GetCurrentStage)() then
    (ExpeditionMgr.RefreshMerchantData)(msg.exBuy)
  else
    ;
    (ExpeditionMgr.RefreshSpecialMerchantData)(msg.exBuy)
  end
  UIMgr:SendWindowMessage((WinResConfig.ExpeditionEventWindow).name, (WindowMsgEnum.ExpeditionEventWindow).REFRESH_SHOP_LIST)
  UIMgr:SendWindowMessage((WinResConfig.ExpeditionShopWindowWindow).name, (WindowMsgEnum.ExpeditionEventWindow).REFRESH_SHOP_LIST)
end

;
(ExpeditionService.Init)()

