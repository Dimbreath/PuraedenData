-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_ShopBuyWindowByName")
local ShopBuyData = {}
local ShopBuyWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local buyData, _currentType, itemID = nil, nil, nil
ShopBuyWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, buyData, ShopBuyWindow, itemID
  bridgeObj:SetView((WinResConfig.ShopBuyWindow).package, (WinResConfig.ShopBuyWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetShop_ShopBuyWindowUis(contentPane)
  uis = uis.ShopBuyGrp
  buyData = argTable[1]
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ChangeNumberTxt).text = 1
  ;
  (ShopBuyWindow.InitBtn)()
  local PoolData = ((TableData.gTable).BaseShopPoolData)[buyData.poolID]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  itemID = tonumber(configItem[2])
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.titilenameTxt).text = (PUtil.get)(20000361)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.HaveNumber_01_Txt).text = (PUtil.get)(20000348)
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.Word_01_Txt).text = (PUtil.get)(20000392)
end

ShopBuyWindow.InitBtn = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, ShopBuyWindow, itemID, buyData, _currentType
  ((uis.ReduceBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV, uis, ShopBuyWindow
    local times = tonumber((uis.ChangeNumberTxt).text) - 1
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    if (ShopBuyWindow.CheckIsSatisfiedTimes)(times, true) then
      (uis.ChangeNumberTxt).text = times
      ;
      (ShopBuyWindow.SetBuyConsume)(times)
    end
  end
)
  ;
  ((uis.AddBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV, uis, ShopBuyWindow, itemID
    local times = tonumber((uis.ChangeNumberTxt).text) + 1
    local maxPhysical = (ShopBuyWindow.GetMaxPhysicalTimes)()
    if maxPhysical <= tonumber((uis.ChangeNumberTxt).text) and itemID == AssetType.PHYSICAL then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
      return 
    end
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

    if (ShopBuyWindow.CheckIsSatisfiedTimes)(times, true) then
      (uis.ChangeNumberTxt).text = times
      ;
      (ShopBuyWindow.SetBuyConsume)(times)
    end
  end
)
  ;
  ((uis.Add10Btn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : ShopBuyWindow, _ENV, uis, itemID, buyData
    local maxTime = (ShopBuyWindow.GetMaxBuyTimes)()
    local maxPhysical = (ShopBuyWindow.GetMaxPhysicalTimes)()
    maxTime = (math.min)(maxTime, maxPhysical)
    local cutTime = tonumber((uis.ChangeNumberTxt).text)
    if maxPhysical <= cutTime and itemID == AssetType.PHYSICAL then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
      return 
    end
    local times = (math.min)(cutTime + 10, maxTime)
    if maxTime < buyData.MaxNum and cutTime == maxTime then
      local itemId = (ShopBuyWindow.GetConsumptionIdAndNum)(cutTime)
      local asset = ((TableData.gTable).BaseAssetData)[tonumber(itemId)]
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000125, asset.name))
      return 
    end
    do
      if not (ShopBuyWindow.CheckIsSatisfiedTimes)(times, maxTime == cutTime) then
        times = maxTime
      end
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (uis.ChangeNumberTxt).text = times
      ;
      (ShopBuyWindow.SetBuyConsume)(times)
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
)
  ;
  ((uis.MaxBtn).onClick):Set(function(...)
    -- function num : 0_1_3 , upvalues : ShopBuyWindow, _ENV, uis, itemID
    local maxTime = (ShopBuyWindow.GetMaxBuyTimes)()
    local maxPhysical = (ShopBuyWindow.GetMaxPhysicalTimes)()
    maxTime = (math.min)(maxTime, maxPhysical)
    local cutTime = tonumber((uis.ChangeNumberTxt).text)
    if maxPhysical <= cutTime and itemID == AssetType.PHYSICAL then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
      return 
    end
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.ChangeNumberTxt).text = maxTime
    ;
    (ShopBuyWindow.SetBuyConsume)(tonumber((uis.ChangeNumberTxt).text))
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_4 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ShopBuyWindow).name)
  end
)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BuyBtn).text = (PUtil.get)(20000079)
  ;
  ((uis.BuyBtn).onClick):Set(function(...)
    -- function num : 0_1_5 , upvalues : ShopBuyWindow, _ENV, uis, buyData, _currentType
    local itemId, Num, getId, getNum, type = (ShopBuyWindow.GetConsumptionIdAndNum)(tonumber((uis.ChangeNumberTxt).text))
    ;
    (MessageMgr.OpenCostResConfirmWindow)(60000523, type .. ":" .. itemId .. ":" .. Num, function(...)
      -- function num : 0_1_5_0 , upvalues : _ENV, buyData, _currentType, getNum, uis
      local PoolData = ((TableData.gTable).BaseShopPoolData)[buyData.poolID]
      local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, buyData.buyTime)
      if _currentType == PropType.EQUIP and (EquiptMgr.CheckShowEquipBagConfirm)(EquiptAcquireType.Shop, nil, true) then
        return 
      end
      if tonumber(str[2]) == AssetType.PHYSICAL then
        local FixedData = ((TableData.gTable).BaseFixedData)[Const.MaxPhysicalFixedID]
        local configData = split(FixedData.array_value, ":")
        local max = tonumber(configData[2])
        local possess = (ActorData.GetAssetCount)(AssetType.PHYSICAL)
        if max < possess + getNum then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
          return 
        end
      end
      do
        ;
        (ShopService.OnReqShopBuy)(buyData.shopType, buyData.poolID, buyData.gridID, tonumber((uis.ChangeNumberTxt).text))
      end
    end
, nil, function(...)
      -- function num : 0_1_5_1 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.ShopBuyWindow).name)
    end
, true, (uis.ItemNameTxt).text)
  end
)
end

ShopBuyWindow.GetMaxPhysicalTimes = function(...)
  -- function num : 0_2 , upvalues : buyData, _ENV
  local maxTime = buyData.MaxNum
  local PoolData = ((TableData.gTable).BaseShopPoolData)[buyData.poolID]
  local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, 1)
  if tonumber(str[2]) ~= AssetType.PHYSICAL then
    return maxTime
  end
  local FixedData = ((TableData.gTable).BaseFixedData)[Const.MaxPhysicalFixedID]
  local configData = split(FixedData.array_value, ":")
  local max = tonumber(configData[2])
  local remain = max - (ActorData.GetAssetCount)(AssetType.PHYSICAL)
  local count = 0
  for i = 1, maxTime do
    local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, i - 1)
    count = count + tonumber(str[3])
    if remain < count then
      return (math.max)(i - 1, 1)
    end
  end
  return maxTime
end

ShopBuyWindow.GetMaxBuyTimes = function(...)
  -- function num : 0_3 , upvalues : buyData, ShopBuyWindow, _ENV
  local maxTime = buyData.MaxNum
  while 1 do
    while 1 do
      if maxTime > 0 then
        local itemId, Num = (ShopBuyWindow.GetConsumptionIdAndNum)(maxTime)
        local haveNum = (ActorData.GetAssetCount)(tonumber(itemId))
        if tonumber(itemId) == AssetType.DIAMOND_BIND then
          haveNum = (ActorData.GetAssetCount)(AssetType.DIAMOND) + haveNum
        end
        if Num <= haveNum then
          do return maxTime end
          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    maxTime = maxTime - 1
  end
  do
    return 1
  end
end

ShopBuyWindow.CheckIsSatisfiedTimes = function(times, isShowTips, ...)
  -- function num : 0_4 , upvalues : _ENV, buyData, ShopBuyWindow
  if times <= 0 then
    if isShowTips then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000076))
    end
    return false
  else
    if buyData.MaxNum < times then
      if isShowTips then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000077))
      end
      return false
    else
      local itemId, Num = (ShopBuyWindow.GetConsumptionIdAndNum)(times)
      local haveNum = (ActorData.GetAssetCount)(tonumber(itemId))
      local asset = ((TableData.gTable).BaseAssetData)[tonumber(itemId)]
      if tonumber(itemId) == AssetType.DIAMOND_BIND then
        haveNum = (ActorData.GetAssetCount)(AssetType.DIAMOND) + haveNum
      end
      if haveNum < Num then
        if isShowTips then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000125, asset.name))
        end
        return false
      end
    end
  end
  do
    return true
  end
end

ShopBuyWindow.SetBuyConsume = function(times, ...)
  -- function num : 0_5 , upvalues : ShopBuyWindow, _ENV, uis
  local itemId, Num, getID, getNum, propType = (ShopBuyWindow.GetConsumptionIdAndNum)(times)
  itemId = tonumber(itemId)
  local pData = ((TableData.gTable).BaseAssetData)[itemId]
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.OneLoader).url = (Util.GetItemUrl)(pData.icon)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.OneLoader).visible = Num > 0
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

  if Num <= 0 then
    (uis.OneTxt).text = (PUtil.get)(20000281)
  else
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R7 in 'UnsetPending'

    (uis.OneTxt).text = Num
  end
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

  if propType == PropType.ASSET and not (Util.CheckAssetEnough)(itemId, Num) then
    (uis.OneTxt).color = Const.LackColorRGB
  else
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'

    (uis.OneTxt).color = Const.EnoughColorRGB
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

ShopBuyWindow.GetConsumptionIdAndNum = function(times, ...)
  -- function num : 0_6 , upvalues : _ENV, buyData
  local PoolData = ((TableData.gTable).BaseShopPoolData)[buyData.poolID]
  local consumeConfigs = ((Util.ParseConfigStr)(PoolData.sell_price))[1]
  local costNum = 0
  local getNum = 0
  local costType = nil
  for i = 1, times do
    local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, buyData.buyTime + i - 1)
    costNum = costNum + tonumber(str[3])
    costType = tonumber(str[1])
    local getStr = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, buyData.buyTime + i - 1)
    getNum = getNum + tonumber(getStr[3])
  end
  return consumeConfigs[2], costNum, tonumber(consumeConfigs[1]), getNum, costType
end

ShopBuyWindow.InitBasicInformation = function(...)
  -- function num : 0_7 , upvalues : _ENV, buyData, uis, _currentType
  local PoolData = ((TableData.gTable).BaseShopPoolData)[buyData.poolID]
  local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, buyData.buyTime)
  local Number = str[3]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  local itemData, type = (Util.GetConfigDataByID)(configItem[2])
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.ItemLoader).url = (Util.GetItemUrl)(itemData.icon)
  _currentType = type
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

  if type == PropType.EQUIP then
    (uis.c2Ctr).selectedIndex = 2
    ;
    (CommonWinMgr.RegisterItemLongPress)(uis.ItemLoader, itemData.id)
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (uis.HaveNumberGrp).visible = false
  else
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R6 in 'UnsetPending'

    if type == PropType.ITEM and (itemData.type == PropItemType.CHARACTER_DEBRIS or itemData.type == PropItemType.UNIVERSAL_DEBRIS) then
      (uis.c2Ctr).selectedIndex = 1
      ;
      (CommonWinMgr.RegisterItemLongPress)(uis.ItemLoader, itemData.id)
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (uis.HaveNumberGrp).visible = true
    else
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (uis.c2Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (uis.HaveNumberGrp).visible = true
    end
  end
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.ItemNameTxt).text = itemData.name
  -- DECOMPILER ERROR at PC79: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.HaveNumberTxt).text = (ActorData.GetGoodsCount)(itemData.id, type)
  local DesText = uis.ItemWordTxt
  DesText.UBBEnabled = true
  DesText.text = itemData.remark
end

ShopBuyWindow.SetNeedCardList = function(...)
  -- function num : 0_8 , upvalues : buyData, uis, _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  if buyData.needCards and #buyData.needCards > 0 then
    (uis.CardHeadList).numItems = 0
    for _,v in ipairs(buyData.needCards) do
      local head = (Util.CreateHeadFrameByID)(tonumber(v), false)
      ;
      (uis.CardHeadList):AddChild(head)
    end
  end
end

ShopBuyWindow.OnShown = function(...)
  -- function num : 0_9 , upvalues : ShopBuyWindow, _ENV, uis, buyData
  (ShopBuyWindow.InitBasicInformation)()
  ;
  (ShopBuyWindow.SetBuyConsume)(tonumber((uis.ChangeNumberTxt).text))
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  if #buyData.needCards == 0 and buyData.MaxNum == 1 then
    (uis.c1Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

    if #buyData.needCards == 0 and buyData.MaxNum > 1 then
      (uis.c1Ctr).selectedIndex = 2
    else
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

      if #buyData.needCards > 0 then
        (uis.c1Ctr).selectedIndex = 1
        ;
        (ShopBuyWindow.SetNeedCardList)()
      end
    end
  end
end

ShopBuyWindow.OnHide = function(...)
  -- function num : 0_10
end

ShopBuyWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : uis, contentPane, argTable, buyData
  uis = nil
  contentPane = nil
  argTable = {}
  buyData = nil
end

ShopBuyWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12
end

return ShopBuyWindow

