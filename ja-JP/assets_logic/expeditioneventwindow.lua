-- params : ...
-- function num : 0 , upvalues : _ENV
require("Expedition_EventUIByName")
require("Expedition_CardHeadByName")
require("Expedition_ItemBuyByName")
GTween = FairyGUI.GTween
local ExpeditionEventWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local stageData = nil
local AddBuffState = {FIGURE = 1, PERCENT = 2}
local cardListData = {}
local SelectBuff = 0
local ShopListData = {}
local SelectIndex = 0
local stageId = nil
ExpeditionEventWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, stageId, stageData, uis, ExpeditionEventWindow
  bridgeObj:SetView((WinResConfig.ExpeditionEventWindow).package, (WinResConfig.ExpeditionEventWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  stageId = argTable[1]
  stageData = ((TableData.gTable).BaseExpeditionStageData)[stageId]
  contentPane = contentPane:GetChild("EventUI")
  uis = GetExpedition_EventUIUis(contentPane)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.CardReviveGrp).CardList).itemRenderer = ExpeditionEventWindow.CardItemRenderer
  ;
  (ExpeditionEventWindow.InitEvent)()
end

ExpeditionEventWindow.InitEvent = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, stageData, stageId
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : uis, _ENV, stageData
    if (uis.c1Ctr).selectedIndex == 3 then
      (ExpeditionService.OnReqSettleExpedition)(stageData.id)
    end
    UIMgr:CloseWindow((WinResConfig.ExpeditionEventWindow).name)
  end
)
  ;
  ((uis.ChoiceBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : uis, _ENV, stageData
    if (uis.c1Ctr).selectedIndex == 3 then
      (ExpeditionService.OnReqSettleExpedition)(stageData.id)
    end
    UIMgr:CloseWindow((WinResConfig.ExpeditionEventWindow).name)
  end
)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ChoiceBtn).text = (PUtil.get)(20000016)
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : uis, _ENV, stageId
    if (uis.c1Ctr).selectedIndex == 2 then
      UIMgr:CloseWindow((WinResConfig.ExpeditionEventWindow).name)
      UIMgr:SendWindowMessage((WinResConfig.ExpeditionWindow).name, (WindowMsgEnum.ExpeditionWindow).GOTO_NEXT_POINT, stageId)
    end
  end
)
end

ExpeditionEventWindow.CardItemRenderer = function(index, obj, ...)
  -- function num : 0_2 , upvalues : _ENV, cardListData, SelectIndex, uis
  local model = GetExpedition_CardHeadUis(obj)
  local data = cardListData[index + 1]
  local cardData = (CardData.GetCardData)(data.cardId)
  ;
  (Util.SetHeadFrameByOneCard)((model.HeadFrameGrp).root, cardData)
  local hp = (obj:GetChild("HpBar")).asProgress
  local Dander = (obj:GetChild("DanderBar")).asProgress
  local c2 = obj:GetController("c2")
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (model.BattelNumberTxt).text = cardData.fc
  if data.cardState == (ExpeditionMgr.CardState).Dead then
    hp.value = 0
    Dander.value = 0
    c2.selectedIndex = 1
  else
    hp.value = data.supHp / cardData.max_hp * 100
    Dander.value = data.supDander / cardData.max_dander * 100
    c2.selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

  if index == SelectIndex then
    (model.c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (model.c1Ctr).selectedIndex = 0
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : SelectIndex, index, model, uis
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    if SelectIndex ~= index then
      (model.c1Ctr).selectedIndex = 1
      ;
      ((((uis.CardReviveGrp).CardList):GetChildAt(SelectIndex)):GetController("c1")).selectedIndex = 0
      SelectIndex = index
    end
  end
)
end

ExpeditionEventWindow.OnClickSelectCard = function(data, ...)
  -- function num : 0_3 , upvalues : _ENV, SelectBuff, ExpeditionEventWindow, stageData
  local cardData = (CardData.GetCardData)(data.cardId)
  local buff = ((TableData.gTable).BaseBuffPreBattleData)[tonumber(SelectBuff)]
  if buff.type == (ExpeditionMgr.BuffType).SingleHeal then
    local addType = (ExpeditionEventWindow.GetBuffValueIsHpOrDanger)(SelectBuff)
    if addType == BattleCardAttributeID.HP then
      if cardData.max_hp <= data.supHp then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000119))
      else
        ;
        (ExpeditionService.OnReqDrawBuff)(stageData.id, SelectBuff, cardData.id)
      end
    else
      if addType == BattleCardAttributeID.DANDER then
        if cardData.max_dander <= data.supDander then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000120))
        else
          ;
          (ExpeditionService.OnReqDrawBuff)(stageData.id, SelectBuff, cardData.id)
        end
      end
    end
  else
    do
      if buff.type == (ExpeditionMgr.BuffType).SingleResurgence then
        (ExpeditionService.OnReqDrawBuff)(stageData.id, SelectBuff, cardData.id)
      end
    end
  end
end

ExpeditionEventWindow.OnSetChooseAltar = function(...)
  -- function num : 0_4 , upvalues : _ENV, ExpeditionEventWindow, uis, SelectBuff
  local buffs = (ExpeditionMgr.ExpeditionAltarData)()
  ;
  (ExpeditionEventWindow.SetBuffData)((uis.BuffListGrp).FirstBtn, buffs[1], 2)
  ;
  (ExpeditionEventWindow.SetBuffData)((uis.BuffListGrp).SecondBtn, buffs[2], 1)
  ;
  (ExpeditionEventWindow.SetBuffData)((uis.BuffListGrp).ThirdBtn, buffs[3], 0)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ChoiceBtn).text = (PUtil.get)(20000107)
  ;
  ((uis.ChoiceBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : uis, SelectBuff, buffs, ExpeditionEventWindow
    local ChooseIndex = ((uis.BuffListGrp).c1Ctr).selectedIndex
    SelectBuff = buffs[ChooseIndex + 1]
    ;
    (ExpeditionEventWindow.OnChoiceBuff)(SelectBuff)
  end
)
end

ExpeditionEventWindow.OnChoiceBuff = function(buffId, ...)
  -- function num : 0_5 , upvalues : _ENV, stageData, ExpeditionEventWindow
  local buff = ((TableData.gTable).BaseBuffPreBattleData)[tonumber(buffId)]
  if buff.type == (ExpeditionMgr.BuffType).Addition then
    (ExpeditionService.OnReqDrawBuff)(stageData.id, buffId)
    UIMgr:CloseWindow((WinResConfig.ExpeditionEventWindow).name)
  else
    if buff.type == (ExpeditionMgr.BuffType).SingleHeal then
      local addType = (ExpeditionEventWindow.GetBuffValueIsHpOrDanger)(buffId)
      if addType == BattleCardAttributeID.HP then
        if (ExpeditionEventWindow.GetTeamHpEnough)() then
          (ExpeditionEventWindow.OnSetGetBuffCard)(buff.type)
        else
          ;
          (MessageMgr.SendCenterTips)((PUtil.get)(20000121))
        end
      else
        if addType == BattleCardAttributeID.DANDER then
          if (ExpeditionEventWindow.GetTeamDangerEnough)() then
            (ExpeditionEventWindow.OnSetGetBuffCard)(buff.type)
          else
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(20000122))
          end
        end
      end
    else
      do
        if buff.type == (ExpeditionMgr.BuffType).SingleResurgence then
          local deadS = (ExpeditionEventWindow.GetTeamIsAlive)(false)
          if #deadS > 0 then
            (ExpeditionEventWindow.OnSetGetBuffCard)(buff.type)
          else
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(20000123))
          end
        else
          do
            if buff.type == (ExpeditionMgr.BuffType).EntireHeal then
              (ExpeditionService.OnReqDrawBuff)(stageData.id, buffId)
            end
          end
        end
      end
    end
  end
end

ExpeditionEventWindow.OnSetGetBuffCard = function(type, ...)
  -- function num : 0_6 , upvalues : uis, _ENV, cardListData, ExpeditionEventWindow, SelectIndex
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = 1
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(20000323)
  cardListData = {}
  if type == (ExpeditionMgr.BuffType).SingleHeal then
    cardListData = (ExpeditionEventWindow.GetTeamIsAlive)(true)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.CardReviveGrp).CardList).numItems = #cardListData
  else
    if type == (ExpeditionMgr.BuffType).SingleResurgence then
      cardListData = (ExpeditionEventWindow.GetTeamIsAlive)(false)
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.CardReviveGrp).CardList).numItems = #cardListData
    end
  end
  ;
  ((uis.ChoiceBtn).onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : uis, ExpeditionEventWindow, cardListData, SelectIndex
    if (uis.c1Ctr).selectedIndex == 1 then
      (ExpeditionEventWindow.OnClickSelectCard)(cardListData[SelectIndex + 1])
    end
  end
)
end

ExpeditionEventWindow.GetBuffValueIsHpOrDanger = function(buffId, ...)
  -- function num : 0_7 , upvalues : ExpeditionEventWindow, _ENV
  local v1, v2, v3 = (ExpeditionEventWindow.GetBuffValue)(buffId)
  return tonumber(v2)
end

ExpeditionEventWindow.GetAddBuffValuePercent = function(buffId, ...)
  -- function num : 0_8 , upvalues : ExpeditionEventWindow, _ENV, AddBuffState
  local v1, v2, v3 = (ExpeditionEventWindow.GetBuffValue)(buffId)
  if tonumber(v1) == AddBuffState.PERCENT then
    return tonumber(v3) / 10000
  else
    if tonumber(v2) == BattleCardAttributeID.DANDER then
      return tonumber(v3) / 1000
    end
  end
end

ExpeditionEventWindow.GetBuffValue = function(buffId, ...)
  -- function num : 0_9 , upvalues : _ENV
  local buff = ((TableData.gTable).BaseBuffPreBattleData)[tonumber(buffId)]
  local value = buff.value
  local valueS = split(value, ":")
  return valueS[1], valueS[2], valueS[3]
end

ExpeditionEventWindow.GetTeamHpEnough = function(...)
  -- function num : 0_10 , upvalues : _ENV
  local cardS = (ExpeditionMgr.GetAlreadyFightCard)()
  for _,v in ipairs(cardS) do
    local oneCard = (CardData.GetCardData)(v.cardId)
    if v.supHp < oneCard.max_hp then
      return true
    end
  end
  return false
end

ExpeditionEventWindow.GetTeamDangerEnough = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local cardS = (ExpeditionMgr.GetAlreadyFightCard)()
  for _,v in ipairs(cardS) do
    local oneCard = (CardData.GetCardData)(v.cardId)
    if v.supDander < oneCard.max_dander and v.cardState ~= (ExpeditionMgr.CardState).Dead then
      return true
    end
  end
  return false
end

ExpeditionEventWindow.GetTeamIsAlive = function(isAlive, ...)
  -- function num : 0_12 , upvalues : _ENV
  local cardS = (ExpeditionMgr.GetAlreadyFightCard)()
  local deadS = {}
  for _,v in ipairs(cardS) do
    -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

    if isAlive and v.cardState ~= (ExpeditionMgr.CardState).Dead then
      (table.insert)(deadS, v)
    end
    if v.cardState == (ExpeditionMgr.CardState).Dead then
      (table.insert)(deadS, v)
    end
  end
  ;
  (table.sort)(deadS, function(a, b, ...)
    -- function num : 0_12_0 , upvalues : _ENV
    local aID = a.cardId
    local aFc = ((CardData.GetCardData)(aID)).fc
    local bID = b.cardId
    local bFc = ((CardData.GetCardData)(bID)).fc
    do return aFc < bFc end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return deadS
end

ExpeditionEventWindow.SetBuffData = function(model, buffId, index, ...)
  -- function num : 0_13 , upvalues : _ENV
  if not buffId then
    model.visible = false
    return 
  end
  local buff = ((TableData.gTable).BaseBuffPreBattleData)[tonumber(buffId)]
  local icon = (model:GetChild("BuffIconGrp")):GetChild("BuffIconLoader")
  icon.url = (Util.GetItemUrl)(buff.icon)
  local name = model:GetChild("Word_01_Txt")
  name.text = buff.name
  local des = model:GetChild("Word_02_Txt")
  des.text = buff.remark
  ChangeUIController(model, "c1", index)
end

ExpeditionEventWindow.OnShown = function(...)
  -- function num : 0_14 , upvalues : stageData, _ENV, uis, ExpeditionEventWindow
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  if stageData.type == (ExpeditionMgr.StageType).Altar then
    (uis.c1Ctr).selectedIndex = 0
    ;
    (ExpeditionEventWindow.OnSetChooseAltar)()
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.TitleTxt).text = (PUtil.get)(20000322)
  else
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

    if stageData.type == (ExpeditionMgr.StageType).Merchant then
      (uis.c1Ctr).selectedIndex = 3
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.ItemBuyListGrp).ItemBuyList).itemRenderer = ExpeditionEventWindow.ShopListRenderer
      ;
      (ExpeditionEventWindow.RefreshShopList)()
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.TitleTxt).text = (PUtil.get)(20000321)
    end
  end
end

ExpeditionEventWindow.OnClickShopArrow = function(right, ...)
  -- function num : 0_15 , upvalues : _ENV, ExpeditionEventWindow, stageData
  local ShopStage = (ExpeditionMgr.GetExternalShop)()
  local index = (ExpeditionEventWindow.GetShopSort)()
  if right then
    index = index + 1
  else
    index = index - 1
  end
  local stageID = ShopStage[index]
  stageData = ((TableData.gTable).BaseExpeditionStageData)[stageID]
  ;
  (ExpeditionEventWindow.RefreshShopList)()
end

ExpeditionEventWindow.ShopListRenderer = function(index, obj, ...)
  -- function num : 0_16 , upvalues : ShopListData, _ENV, stageData
  local shopData = ShopListData[index + 1]
  local model = GetExpedition_ItemBuyUis(obj)
  local supTime = shopData.supTime
  local configData = shopData.data
  local configItem = split(configData.reward, ":")
  local itemData, DataType = (Util.GetConfigDataByID)(configItem[2])
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (model.IconLoader).url = (Util.GetItemUrl)(itemData.icon)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (model.Word_01_Txt).text = itemData.name
  local shopNum = tonumber(configItem[3]) or 1
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R10 in 'UnsetPending'

  ;
  (model.IconNumberTxt).text = shopNum
  ;
  (Util.SetConsumption)(configData.cost, model.SpendLoader, model.SpendNumberTxt)
  local consumeConfigs = split(configData.cost, ":")
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R11 in 'UnsetPending'

  if tonumber(consumeConfigs[3]) == 0 then
    (model.c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (model.c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.BuyNumberTxt).text = (PUtil.get)(20000320, supTime)
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R11 in 'UnsetPending'

  if supTime > 0 then
    (model.c2Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (model.c2Ctr).selectedIndex = 1
  end
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.BuyBtn).text = (PUtil.get)(20000079)
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.BuyBtn).grayed = supTime == 0
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.BuyBtn).touchable = supTime > 0
  ;
  ((model.BuyBtn).onClick):Set(function(...)
    -- function num : 0_16_0 , upvalues : supTime, _ENV, configData, stageData
    if supTime > 0 and (Util.CheckCostResources)(configData.cost) then
      (ExpeditionService.OnReqBuyExpedition)(stageData.id, configData.id)
    end
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(20000124))
  end
)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ExpeditionEventWindow.GetShopSort = function(...)
  -- function num : 0_17 , upvalues : _ENV, stageData
  local ShopStage = (ExpeditionMgr.GetExternalShop)()
  for i,v in ipairs(ShopStage) do
    if v == stageData.id then
      return i
    end
  end
end

ExpeditionEventWindow.RefreshShopList = function(...)
  -- function num : 0_18 , upvalues : ShopListData, _ENV, uis
  ShopListData = {}
  local buyData = {}
  buyData = (ExpeditionMgr.ExpeditionMerchantData)()
  for _,v in ipairs(buyData) do
    local configData = (ExpeditionMgr.GetShopDataConfig)(v.shopType, v.buyNum)
    if configData then
      local shopData = {}
      shopData.supTime = v.totalNum - v.buyNum
      shopData.data = configData
      ;
      (table.insert)(ShopListData, shopData)
    end
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.ItemBuyListGrp).ItemBuyList).numItems = #ShopListData
end

ExpeditionEventWindow.OnHide = function(...)
  -- function num : 0_19
end

ExpeditionEventWindow.OnClose = function(...)
  -- function num : 0_20 , upvalues : SelectIndex, uis, contentPane, stageData
  SelectIndex = 0
  uis = nil
  contentPane = nil
  stageData = nil
end

ExpeditionEventWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_21 , upvalues : _ENV, uis, ExpeditionEventWindow, cardListData, stageData, stageId
  local data = nil
  if para then
    data = para
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if msgId == (WindowMsgEnum.ExpeditionEventWindow).SINGLE_HEAL then
    (uis.c1Ctr).selectedIndex = 2
    ;
    (ExpeditionEventWindow.PlayCardAddHPOrDanger)(data.cardId, data.buffId)
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.TitleTxt).text = (PUtil.get)(20000323)
  else
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

    if msgId == (WindowMsgEnum.ExpeditionEventWindow).SINGLE_REGAIN then
      (uis.c1Ctr).selectedIndex = 2
      ;
      (ExpeditionEventWindow.PlayRegainAni)(data.cardId, data.buffId)
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.TitleTxt).text = (PUtil.get)(20000323)
    else
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

      if msgId == (WindowMsgEnum.ExpeditionEventWindow).ENTIRE_HEAL then
        (uis.c1Ctr).selectedIndex = 2
        cardListData = (ExpeditionEventWindow.GetTeamIsAlive)(true)
        -- DECOMPILER ERROR at PC55: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((uis.CardReviveGrp).CardList).numItems = #cardListData
        for _,v in ipairs(cardListData) do
          (ExpeditionEventWindow.PlayCardAddHPOrDanger)(v.cardId, data.buffId)
        end
        -- DECOMPILER ERROR at PC71: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.TitleTxt).text = (PUtil.get)(20000323)
      else
        if msgId == (WindowMsgEnum.ExpeditionEventWindow).REFRESH_SHOP_LIST then
          (ExpeditionEventWindow.RefreshShopList)()
        end
      end
    end
  end
  ;
  ((uis.ChoiceBtn).onClick):Set(function(...)
    -- function num : 0_21_0 , upvalues : uis, _ENV, stageData, stageId
    if (uis.c1Ctr).selectedIndex == 3 then
      (ExpeditionService.OnReqSettleExpedition)(stageData.id)
    else
      UIMgr:SendWindowMessage((WinResConfig.ExpeditionWindow).name, (WindowMsgEnum.ExpeditionWindow).GOTO_NEXT_POINT, stageId)
    end
    UIMgr:CloseWindow((WinResConfig.ExpeditionEventWindow).name)
  end
)
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.ChoiceBtn).text = (PUtil.get)(20000016)
end

ExpeditionEventWindow.PlayRegainAni = function(cardId, buffId, ...)
  -- function num : 0_22 , upvalues : ExpeditionEventWindow, uis, _ENV
  local index = (ExpeditionEventWindow.GetListIndex)(cardId)
  local obj = ((uis.CardReviveGrp).CardList):GetChildAt(index)
  ChangeUIController(obj, "c2", 0)
  ;
  (SimpleTimer.setTimeout)(0.2, function(...)
    -- function num : 0_22_0 , upvalues : ExpeditionEventWindow, cardId, buffId
    (ExpeditionEventWindow.PlayCardAddHPOrDanger)(cardId, buffId)
  end
)
end

ExpeditionEventWindow.PlayCardAddHPOrDanger = function(cardId, buffId, ...)
  -- function num : 0_23 , upvalues : ExpeditionEventWindow, uis, _ENV
  local index = (ExpeditionEventWindow.GetListIndex)(cardId)
  local obj = (((uis.CardReviveGrp).CardList):GetChildAt(index))
  local slider = nil
  local addType = (ExpeditionEventWindow.GetBuffValueIsHpOrDanger)(buffId)
  if BattleCardAttributeID.HP == addType then
    slider = (obj.asCom):GetChild("HpBar")
  else
    if addType == BattleCardAttributeID.DANDER then
      slider = (obj.asCom):GetChild("DanderBar")
    end
  end
  local addValue = (ExpeditionEventWindow.GetAddBuffValuePercent)(buffId)
  local startValue = slider.value
  local endValue = slider.value + addValue * 100
  local gt = (GTween.To)(startValue, endValue, 1)
  gt:OnUpdate(function(...)
    -- function num : 0_23_0 , upvalues : slider, gt
    slider.value = (gt.value).x
  end
)
end

ExpeditionEventWindow.GetListIndex = function(cardId, ...)
  -- function num : 0_24 , upvalues : cardListData, _ENV
  local data = cardListData
  for i,v in ipairs(data) do
    if v.cardId == cardId then
      return i - 1
    end
  end
end

return ExpeditionEventWindow

