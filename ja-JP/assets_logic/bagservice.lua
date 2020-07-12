-- params : ...
-- function num : 0 , upvalues : _ENV
BagService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

BagService.init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResUseProp, BagService.ResUseProp)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

BagService.UseProp = function(itemId, propIndex, count, ...)
  -- function num : 0_1 , upvalues : _ENV
  local propData = ((TableData.gTable).BasePropData)[itemId]
  if propData.type == PropItemType.GIFT_OPTIONAL then
    OpenWindow((WinResConfig.BagGiftOptionWindow).name, UILayer.HUD1, itemId, count, propIndex)
  else
    if propData.type == PropItemType.GIFT_OPTIONAL_BREAK then
      OpenWindow((WinResConfig.BagBreakOptionWindow).name, UILayer.HUD1, itemId, propIndex)
    else
      ;
      (BagService.ReqUseProp)(itemId, propIndex, count)
    end
  end
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

BagService.ReqUseProp = function(itemId, propId, count, ...)
  -- function num : 0_2 , upvalues : _ENV
  local propData = ((TableData.gTable).BasePropData)[itemId]
  if propData.type == PropItemType.ASSET_ITEM then
    local effect_value = split(propData.effect_value, ":")
    local effectID = tonumber(effect_value[1])
    local effectValue = tonumber(effect_value[2])
    local max = (Util.GetMaxAssetNum)(effectID)
    if max < effectValue * count + (ActorData.GetAssetCount)(effectID) then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000184))
      return 
    end
  else
    do
      if propData.type == PropItemType.GIFT and (Util.GetGiftIsContainEquip)(itemId) and (Util.GetEquipRemainSlot)() <= 0 then
        (EquiptMgr.CheckShowEquipBagConfirm)(EquiptAcquireType.Gift, nil, true)
        return 
      end
      local limitLv = split(propData.use_level, ":")
      if #limitLv > 1 then
        local minLV = tonumber(limitLv[1])
        local maxLV = tonumber(limitLv[2])
        local mLV = (ActorData.GetLevel)()
        if mLV < minLV then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000307))
          return 
        else
          if maxLV < mLV then
            (MessageMgr.SendCenterTips)((PUtil.get)(20000306))
            return 
          end
        end
      end
      do
        local m = {}
        m.propIndex = propId
        m.count = count
        m.cardId = (((CardData.GetObtainedCardList)())[1]).id
        ;
        (Net.Send)((Proto.MsgName).ReqUseProp, m, (Proto.MsgName).ResUseProp)
      end
    end
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

BagService.ReqUseOptionGift = function(propId, count, propList, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.count = count
  m.propIndex = propId
  m.dropInfo = propList
  ;
  (Net.Send)((Proto.MsgName).ReqUseProp, m, (Proto.MsgName).ResUseProp)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

BagService.ResUseProp = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  local propData = ((TableData.gTable).BasePropData)[msg.propId]
  if propData.type == PropItemType.ASSET_ITEM then
    (MessageMgr.OpenItemBuyTipsWindowByGoodsObj)(msg.GainGoods)
  else
    if propData.type == PropItemType.GIFT then
      UIMgr:CloseWindow((WinResConfig.BagSellAndBuyWindow).name, true, true)
      ;
      (ActorService.OtherWayToGetCardShow)(msg.GainGoods, function(...)
    -- function num : 0_4_0 , upvalues : _ENV, msg
    (MessageMgr.OpenRewardByGoods)(msg.GainGoods)
  end
)
    else
      if propData.type == PropItemType.COMPOUND_DEBRIS then
        (MessageMgr.OpenItemBuyTipsWindowByGoodsObj)(msg.GainGoods)
      else
        if propData.type == PropItemType.GIFT_OPTIONAL then
          UIMgr:CloseWindow((WinResConfig.BagGiftOptionWindow).name, true, true)
          ;
          (ActorService.OtherWayToGetCardShow)(msg.GainGoods, function(...)
    -- function num : 0_4_1 , upvalues : _ENV, msg
    (MessageMgr.OpenRewardByGoods)(msg.GainGoods)
  end
)
        else
          if propData.type == PropItemType.GIFT_OPTIONAL_BREAK then
            UIMgr:CloseWindow((WinResConfig.BagBreakOptionWindow).name, true, true)
            ;
            (MessageMgr.OpenRewardByGoods)(msg.GainGoods)
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

BagService.ReqSellProp = function(propid, count, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.propIndex = propid
  m.count = count
  ;
  (Net.Send)((Proto.MsgName).ReqSellProp, m, (Proto.MsgName).ResGoodsChange)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

BagService.ResSellProp = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  print("出售道具-------", msg.propId)
end

;
(BagService.init)()

