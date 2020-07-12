-- params : ...
-- function num : 0 , upvalues : _ENV
require("Gift_StageChoiceWindowByName")
local BagBreakOptionWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local MAX_STAGE = (((TableData.gTable).BaseFixedData)[Const.MAX_CARDSTAGE]).int_value
local cardListData = {}
local giftID = nil
local mItemListTable = {}
local mItemListData = {}
local mSelectItemTable = {}
local mItemCorNum = {}
local propIndex = nil
BagBreakOptionWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, giftID, propIndex, mSelectItemTable, uis, BagBreakOptionWindow
  bridgeObj:SetView((WinResConfig.BagBreakOptionWindow).package, (WinResConfig.BagBreakOptionWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  giftID = tonumber(argTable[1])
  propIndex = argTable[2]
  mSelectItemTable = {}
  uis = GetGift_StageChoiceWindowUis(contentPane)
  uis = uis.StageChoice
  ;
  (BagBreakOptionWindow.InitInvariable)()
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CardList).itemRenderer = BagBreakOptionWindow.CardRenderer
  ;
  (uis.CardList):SetVirtual()
  ;
  (BagBreakOptionWindow.SetCardList)()
  ;
  (BagBreakOptionWindow.InitGiftItemList)()
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.StageItemList).itemRenderer = BagBreakOptionWindow.ItemRenderer
  ;
  (uis.StageItemList):SetVirtual()
  ;
  (BagBreakOptionWindow.SetItemShow)()
  ;
  (BagBreakOptionWindow.SetGiftNum)()
end

BagBreakOptionWindow.ItemRenderer = function(index, obj, ...)
  -- function num : 0_1 , upvalues : mItemListData, _ENV, mSelectItemTable, BagBreakOptionWindow
  local itemStr = mItemListData[index + 1]
  if itemStr == nil then
    return 
  end
  local itemStr = split(itemStr, ":")
  local itemID = tonumber(itemStr[2])
  local itemNum = tonumber(itemStr[3])
  local config = ((TableData.gTable).BasePropData)[itemID]
  local item = obj:GetChild("ItemFrame")
  local iconLoader = item:GetChild("IconLoader")
  iconLoader.url = (Util.GetItemUrl)(config.icon)
  ;
  (item:GetController("Quality")).selectedIndex = config.quality
  ;
  (item:GetChild("NumberTxt")).text = itemNum
  local selectNum = mSelectItemTable[itemID]
  local NumberTxt = obj:GetChild("NumberTxt")
  NumberTxt.text = selectNum or 0
  local addBtn = obj:GetChild("AddBtn")
  local reduceBtn = obj:GetChild("ReduceBtn")
  ;
  (addBtn.onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : BagBreakOptionWindow, itemID, mSelectItemTable, NumberTxt
    if (BagBreakOptionWindow.ModifyItemNum)(1, itemID) then
      local thenNum = mSelectItemTable[itemID]
      NumberTxt.text = thenNum
    end
  end
)
  ;
  (reduceBtn.onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : BagBreakOptionWindow, itemID, mSelectItemTable, NumberTxt
    if (BagBreakOptionWindow.ModifyItemNum)(-1, itemID) then
      local thenNum = mSelectItemTable[itemID]
      NumberTxt.text = thenNum
    end
  end
)
  ;
  (BagBreakOptionWindow.RegisterLongPress)(addBtn, function(...)
    -- function num : 0_1_2 , upvalues : BagBreakOptionWindow, itemID, mSelectItemTable, NumberTxt
    if (BagBreakOptionWindow.ModifyItemNum)(1, itemID) then
      local thenNum = mSelectItemTable[itemID]
      NumberTxt.text = thenNum
      return true
    end
  end
)
  ;
  (BagBreakOptionWindow.RegisterLongPress)(reduceBtn, function(...)
    -- function num : 0_1_3 , upvalues : BagBreakOptionWindow, itemID, mSelectItemTable, NumberTxt
    if (BagBreakOptionWindow.ModifyItemNum)(-1, itemID) then
      local thenNum = mSelectItemTable[itemID]
      NumberTxt.text = thenNum
      return true
    end
  end
)
end

BagBreakOptionWindow.ModifyItemNum = function(modify, itemID, ...)
  -- function num : 0_2 , upvalues : mSelectItemTable, BagBreakOptionWindow, _ENV, giftID, uis
  local currentNum = mSelectItemTable[itemID] or 0
  local thenNum = currentNum + modify
  local countNum = (BagBreakOptionWindow.GetSelectCountNum)()
  local possess = (ActorData.GetPropsByID)(giftID)
  if possess < countNum + modify then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000423))
    return false
  else
    if thenNum < 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000424))
      return false
    end
  end
  mSelectItemTable[itemID] = thenNum
  ;
  (BagBreakOptionWindow.SetGiftNum)()
  ;
  (uis.CardList):RefreshVirtualList()
  return true
end

BagBreakOptionWindow.SetGiftNum = function(...)
  -- function num : 0_3 , upvalues : BagBreakOptionWindow, _ENV, giftID, uis
  local count = (BagBreakOptionWindow.GetSelectCountNum)()
  local possess = (ActorData.GetPropsByID)(giftID)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.GiftNumberTxt).text = (PUtil.get)(20000421, count, possess)
end

BagBreakOptionWindow.GetSelectCountNum = function(...)
  -- function num : 0_4 , upvalues : _ENV, mSelectItemTable
  local num = 0
  for _,v in pairs(mSelectItemTable) do
    num = num + v
  end
  return num
end

BagBreakOptionWindow.RegisterLongPress = function(btn, func, ...)
  -- function num : 0_5 , upvalues : _ENV
  local LongPressAdd = (FairyGUI.LongPressGesture)(btn)
  LongPressAdd.once = false
  LongPressAdd.trigger = 0.2
  LongPressAdd.interval = 0.1
  local speed = 1
  local timer = nil
  ;
  (LongPressAdd.onBegin):Set(function(...)
    -- function num : 0_5_0 , upvalues : speed
    speed = 1
  end
)
  ;
  (LongPressAdd.onAction):Set(function(...)
    -- function num : 0_5_1 , upvalues : _ENV, speed, timer, LongPressAdd, func
    ((FairyGUI.Stage).inst):CancelClick(0)
    speed = speed * 1.05
    local time = (Umath.Clamp)((math.floor)(speed), 1, 75)
    timer = (SimpleTimer.setInterval)(LongPressAdd.interval / time, time, function(...)
      -- function num : 0_5_1_0 , upvalues : func, LongPressAdd, timer
      local value = func()
      if not value then
        LongPressAdd:Cancel()
        timer:stop()
      end
    end
)
  end
)
  ;
  (LongPressAdd.onEnd):Set(function(...)
    -- function num : 0_5_2 , upvalues : timer
    if timer then
      timer:stop()
    end
  end
)
  return LongPressAdd
end

BagBreakOptionWindow.InitGiftItemList = function(...)
  -- function num : 0_6 , upvalues : _ENV, giftID, mItemListTable, BagBreakOptionWindow, mItemCorNum
  local PropData = ((TableData.gTable).BasePropData)[giftID]
  if PropData.type ~= PropItemType.GIFT_OPTIONAL_BREAK then
    return 
  end
  local propType = tonumber(PropData.effect_value)
  local GiftData = (TableData.gTable).BaseDropGroupGiftData
  local mLV = (ActorData.GetLevel)()
  mItemListTable = {}
  for _,v in pairs(GiftData) do
    if v.type == propType then
      local lvLimit = split(v.use_level, ":")
      if tonumber(lvLimit[1]) <= mLV and mLV <= tonumber(lvLimit[2]) then
        local items = split(v.rewards, ",")
        for _,v2 in ipairs(items) do
          (table.insert)(mItemListTable, v2)
        end
      end
    end
  end
  ;
  (table.sort)(mItemListTable, function(a, b, ...)
    -- function num : 0_6_0 , upvalues : BagBreakOptionWindow
    do return (BagBreakOptionWindow.GetItemSort)(b) < (BagBreakOptionWindow.GetItemSort)(a) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for _,v in ipairs(mItemListTable) do
    local str = split(v, ":")
    mItemCorNum[tonumber(str[2])] = tonumber(str[3])
  end
end

BagBreakOptionWindow.GetItemSort = function(itemStr, ...)
  -- function num : 0_7 , upvalues : _ENV
  local str = split(itemStr, ":")
  local PropData = ((TableData.gTable).BasePropData)[tonumber(str[2])]
  return PropData.quality
end

BagBreakOptionWindow.SetItemShow = function(filterGoods, ...)
  -- function num : 0_8 , upvalues : mItemListData, mItemListTable, _ENV, uis
  mItemListData = {}
  if filterGoods == nil or #filterGoods <= 0 then
    mItemListData = mItemListTable
  else
    for _,v in ipairs(mItemListTable) do
      local item = split(v, ":")
      local itemID = tonumber(item[2])
      for _,v2 in ipairs(filterGoods) do
        if v2.id == itemID then
          (table.insert)(mItemListData, v)
          break
        end
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.StageItemList).numItems = #mItemListData
  end
end

BagBreakOptionWindow.CardRenderer = function(index, obj, ...)
  -- function num : 0_9 , upvalues : cardListData, _ENV, mSelectItemTable, mItemCorNum, BagBreakOptionWindow, uis
  local mData = cardListData[index + 1]
  local headIcon = obj:GetChild("HeadFrame")
  local nameTxt = obj:GetChild("NameTxt")
  local itemList = obj:GetChild("ItemList")
  local StageA = obj:GetChild("StageA")
  local StageB = obj:GetChild("StageB")
  local cardData = mData.cardData
  ;
  (Util.SetHeadFrame)(headIcon, cardData, false)
  nameTxt.text = cardData.name
  itemList:RemoveChildrenToPool()
  local goods = mData.GoodsInfo
  for _,v in ipairs(goods) do
    local item = itemList:AddItemFromPool()
    local config = ((TableData.gTable).BasePropData)[v.id]
    local iconLoader = item:GetChild("IconLoader")
    iconLoader.url = (Util.GetItemUrl)(config.icon)
    ;
    (item:GetController("c2")).selectedIndex = config.quality - 1
    local enough = item:GetController("c1")
    local num = item:GetChild("StageTxt")
    local needNum = v.need
    local addNum = mSelectItemTable[v.id] or 0
    local addPer = mItemCorNum[v.id] or 0
    local haveNum = v.have + addNum * addPer
    if needNum <= haveNum then
      num.text = (PUtil.get)(20000420, haveNum, needNum)
      enough.selectedIndex = 0
    else
      num.text = (PUtil.get)(20000064, haveNum, needNum)
      enough.selectedIndex = 1
    end
  end
  ;
  (BagBreakOptionWindow.SetQualityIcon)(StageA, cardData.id, cardData.quality)
  ;
  (BagBreakOptionWindow.SetQualityIcon)(StageB, cardData.id, cardData.quality + 1)
  local isShow = cardData.quality > 0
  StageA.visible = isShow
  StageB.visible = isShow
  ;
  (obj:GetChild("n5")).visible = isShow
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_9_0 , upvalues : uis, index, mSelectItemTable, BagBreakOptionWindow, goods
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (uis.CardList).selectedIndex = index
    mSelectItemTable = {}
    ;
    (BagBreakOptionWindow.SetItemShow)(goods)
    ;
    (uis.CardList):RefreshVirtualList()
    ;
    (BagBreakOptionWindow.SetGiftNum)()
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BagBreakOptionWindow.SetQualityIcon = function(obj, cardID, quality, hide, ...)
  -- function num : 0_10 , upvalues : _ENV
  local StageData = (CardMgr.GetBaseCardQualityData)(quality, cardID)
  local levelShow = split(StageData.level_show, ":")
  ;
  (obj:GetController("c1")).selectedIndex = tonumber(levelShow[1]) - 1
  local LevelTxt = obj:GetChild("LevelTxt")
  LevelTxt.text = quality
end

BagBreakOptionWindow.SetCardList = function(...)
  -- function num : 0_11 , upvalues : cardListData, _ENV, MAX_STAGE, BagBreakOptionWindow, uis
  cardListData = {}
  local cardList = (CardData.GetObtainedCardList)()
  for _,v in ipairs(cardList) do
    if v.quality < MAX_STAGE then
      local mData = {}
      local StageData = (CardMgr.GetBaseCardQualityData)(v.quality + 1, v.id)
      local needGoods = (Util.ParseConfigStr)(StageData.need_goods)
      mData.cardData = v
      local mGoodInfo = {}
      local GoodsEnough = true
      for _,v2 in ipairs(needGoods) do
        if tonumber(v2[1]) == PropType.ITEM then
          local itemID = tonumber(v2[2])
          local needNum = tonumber(v2[3])
          local haveNum = (ActorData.GetPropsByID)(itemID)
          if haveNum < needNum then
            GoodsEnough = false
          end
          ;
          (table.insert)(mGoodInfo, {id = itemID, have = haveNum, need = needNum})
        end
      end
      mData.GoodsInfo = mGoodInfo
      mData.GoodsEnough = GoodsEnough
      ;
      (table.insert)(cardListData, mData)
    end
  end
  ;
  (table.sort)(cardListData, function(a, b, ...)
    -- function num : 0_11_0 , upvalues : BagBreakOptionWindow
    local aWeight = (BagBreakOptionWindow.GetCardSortWeight)(a)
    local bWeight = (BagBreakOptionWindow.GetCardSortWeight)(b)
    do return bWeight < aWeight end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CardList).numItems = #cardListData
end

BagBreakOptionWindow.GetCardSortWeight = function(data, ...)
  -- function num : 0_12
  local weight = 0
  if not data.GoodsEnough then
    weight = 1000000
  end
  return weight + (data.cardData).quality * 1000 + (data.cardData).intelligence
end

BagBreakOptionWindow.InitInvariable = function(...)
  -- function num : 0_13 , upvalues : uis, _ENV, BagBreakOptionWindow, mSelectItemTable, propIndex
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TitleTxt).text = (PUtil.get)(20000417)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_13_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.BagBreakOptionWindow).name)
  end
)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000107)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_13_1 , upvalues : BagBreakOptionWindow, _ENV, mSelectItemTable, propIndex
    local count = (BagBreakOptionWindow.GetSelectCountNum)()
    if count <= 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000422))
      return 
    end
    local dropInfo = {}
    for i,v in pairs(mSelectItemTable) do
      local m = {}
      m.propId = i
      m.count = v
      ;
      (table.insert)(dropInfo, m)
    end
    ;
    (BagService.ReqUseOptionGift)(propIndex, count, dropInfo)
  end
)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ResetBtn).text = (PUtil.get)(60000069)
  ;
  ((uis.ResetBtn).onClick):Set(function(...)
    -- function num : 0_13_2 , upvalues : uis, mSelectItemTable, BagBreakOptionWindow
    (uis.CardList):ClearSelection()
    mSelectItemTable = {}
    ;
    (BagBreakOptionWindow.SetItemShow)()
    ;
    (uis.CardList):RefreshVirtualList()
    ;
    (BagBreakOptionWindow.SetGiftNum)()
  end
)
end

BagBreakOptionWindow.OnShown = function(...)
  -- function num : 0_14
end

BagBreakOptionWindow.OnHide = function(...)
  -- function num : 0_15
end

BagBreakOptionWindow.OnClose = function(...)
  -- function num : 0_16 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

BagBreakOptionWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_17
end

return BagBreakOptionWindow

