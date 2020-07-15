-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_GoldBuyWindowByName")
local AssetBuyWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local assetID, configData = nil, nil
local maxTime = 0
local buyType = 0
local totalTime = 0
AssetBuyWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, assetID, configData, uis, buyType, totalTime, maxTime, AssetBuyWindow
  bridgeObj:SetView((WinResConfig.AssetBuyWindow).package, (WinResConfig.AssetBuyWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  assetID = tonumber(argTable[1])
  configData = ((TableData.gTable).BaseAssetData)[assetID]
  uis = GetMessage_GoldBuyWindowUis(contentPane)
  uis = uis.GoldBuy
  buyType = (AssetShopMgr.GetAssetTypeByID)(assetID)
  totalTime = (AssetShopMgr.GetMaxTimes)(buyType)
  local buyTime = (AssetShopMgr.GetAssetBuyTimeByID)(assetID)
  maxTime = totalTime - buyTime
  ;
  (AssetBuyWindow.SetInvariable)()
  ;
  (AssetBuyWindow.SetBtnEvent)()
end

AssetBuyWindow.SetConsumeAndGetShow = function(times, ...)
  -- function num : 0_1 , upvalues : AssetBuyWindow, _ENV, uis
  local CId, CNum, GID, GNum = (AssetBuyWindow.GetConsumptionIdAndNum)(times)
  local GConfig = ((TableData.gTable).BaseAssetData)[GID]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((uis.GetNumber).IconLoader).url = (Util.GetItemUrl)(GConfig.icon)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((uis.GetNumber).GetNumberTxt).text = (math.floor)(GNum)
  ;
  (Util.SetConsumptionByID)(CId, (math.floor)(CNum), uis.OneLoader, uis.OneTxt, true, true)
end

AssetBuyWindow.SetInvariable = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, configData, assetID, maxTime
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  (uis.titilenameTxt).text = (PUtil.get)(20000345, configData.name)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ItemLoader).url = (Util.GetItemUrl)(configData.icon)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ItemNameTxt).text = configData.name
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.HaveNumberTxt).text = (ActorData.GetAssetCount)(assetID)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ItemWordTxt).text = configData.remark
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuyNumber).NumberTxt).text = maxTime
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.HaveNumber_01_Txt).text = (PUtil.get)(20000348)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.GetNumber).WordTxt).text = (PUtil.get)(20000349)
end

AssetBuyWindow.SetBtnEvent = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV, AssetBuyWindow, maxTime, configData, assetID
  ((uis.ReduceBtn).onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : _ENV, uis, AssetBuyWindow
    local times = tonumber((uis.ChangeNumberTxt).text) - 1
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    if (AssetBuyWindow.CheckIsSatisfiedTimes)(times, true) then
      (uis.ChangeNumberTxt).text = times
      ;
      (AssetBuyWindow.SetConsumeAndGetShow)(times)
    end
  end
)
  ;
  ((uis.AddBtn).onClick):Set(function(...)
    -- function num : 0_3_1 , upvalues : AssetBuyWindow
    (AssetBuyWindow.OnClickAddTime)(1, true)
  end
)
  ;
  ((uis.Add10Btn).onClick):Set(function(...)
    -- function num : 0_3_2 , upvalues : AssetBuyWindow, _ENV, uis, maxTime, configData
    local max = (AssetBuyWindow.GetConsumptionCanGetMaxTime)()
    local maxPhysical = (AssetBuyWindow.GetReserveCanGetMaxTime)()
    max = (math.min)(max, maxPhysical)
    local cutTime = tonumber((uis.ChangeNumberTxt).text)
    if maxPhysical <= cutTime and cutTime < maxTime then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000346, configData.name))
      return 
    end
    local times = (math.min)(cutTime + 10, max)
    if not (AssetBuyWindow.CheckIsSatisfiedTimes)(times, max == cutTime) then
      times = (math.max)(1, times)
    end
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (uis.ChangeNumberTxt).text = times
    ;
    (AssetBuyWindow.SetConsumeAndGetShow)(times)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  ;
  ((uis.MaxBtn).onClick):Set(function(...)
    -- function num : 0_3_3 , upvalues : AssetBuyWindow, _ENV, uis, maxTime, configData
    local max = (AssetBuyWindow.GetConsumptionCanGetMaxTime)()
    local maxPhysical = (AssetBuyWindow.GetReserveCanGetMaxTime)()
    max = (math.min)(max, maxPhysical)
    max = (math.max)(1, max)
    local cutTime = tonumber((uis.ChangeNumberTxt).text)
    if maxPhysical <= cutTime and cutTime < maxTime then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000346, configData.name))
      return 
    end
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.ChangeNumberTxt).text = max
    ;
    (AssetBuyWindow.SetConsumeAndGetShow)(max)
  end
)
  ;
  ((uis.BuyBtn).onClick):Set(function(...)
    -- function num : 0_3_4 , upvalues : _ENV, uis, maxTime, AssetBuyWindow, assetID, configData
    local buyTime = tonumber((uis.ChangeNumberTxt).text)
    if maxTime < buyTime then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000347))
      return 
    end
    local itemId, Num, getId, getNum, type = (AssetBuyWindow.GetConsumptionIdAndNum)(buyTime)
    local tips = assetID + 38900512
    ;
    (MessageMgr.OpenCostResConfirmWindow)(tips, type .. ":" .. itemId .. ":" .. (math.floor)(Num), function(...)
      -- function num : 0_3_4_0 , upvalues : assetID, _ENV, getNum, configData, buyTime
      if assetID ~= AssetType.GOLD then
        local maxReserve = (Util.GetMaxAssetNum)(assetID)
        local possess = (ActorData.GetAssetCount)(assetID)
        if maxReserve < possess + getNum then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000346, configData.name))
          return 
        end
      end
      do
        ;
        (AssetShopService.ReqBuyAssist)((AssetShopMgr.GetPropAssetTypeByID)(assetID), buyTime)
      end
    end
, nil, function(...)
      -- function num : 0_3_4_1 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.ShopBuyWindow).name)
    end
, true)
  end
)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BuyBtn).text = (PUtil.get)(60000045)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_3_5 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.AssetBuyWindow).name)
  end
)
end

AssetBuyWindow.OnClickAddTime = function(addTime, showTips, ...)
  -- function num : 0_4 , upvalues : _ENV, uis, AssetBuyWindow, maxTime, configData
  local times = tonumber((uis.ChangeNumberTxt).text) + addTime
  local maxReserve = (AssetBuyWindow.GetReserveCanGetMaxTime)()
  if maxReserve <= tonumber((uis.ChangeNumberTxt).text) and tonumber((uis.ChangeNumberTxt).text) < maxTime then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000346, configData.name))
    return 
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

  if (AssetBuyWindow.CheckIsSatisfiedTimes)(times, showTips) then
    (uis.ChangeNumberTxt).text = times
    ;
    (AssetBuyWindow.SetConsumeAndGetShow)(times)
  end
end

AssetBuyWindow.GetReserveCanGetMaxTime = function(...)
  -- function num : 0_5 , upvalues : assetID, _ENV, totalTime, AssetBuyWindow
  if assetID == AssetType.GOLD then
    return 99999
  end
  local maxReserve = (Util.GetMaxAssetNum)(assetID)
  local possess = (ActorData.GetAssetCount)(assetID)
  for i = 1, totalTime do
    local itemId, Num, getItems, gNum = (AssetBuyWindow.GetConsumptionIdAndNum)(i)
    gNum = possess + gNum
    if maxReserve < gNum then
      return i - 1
    end
  end
  return totalTime
end

AssetBuyWindow.GetConsumptionCanGetMaxTime = function(...)
  -- function num : 0_6 , upvalues : maxTime, AssetBuyWindow, _ENV
  local Time = maxTime
  while 1 do
    while 1 do
      if Time > 0 then
        local itemId, Num = (AssetBuyWindow.GetConsumptionIdAndNum)(Time)
        local haveNum = (ActorData.GetAssetCount)(tonumber(itemId))
        if tonumber(itemId) == AssetType.DIAMOND_BIND then
          haveNum = (ActorData.GetAssetCount)(AssetType.DIAMOND) + haveNum
        end
        if Num <= haveNum then
          do return Time end
          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    Time = Time - 1
  end
  do
    return 1
  end
end

AssetBuyWindow.CheckIsSatisfiedTimes = function(times, isShowTips, ...)
  -- function num : 0_7 , upvalues : _ENV, maxTime, AssetBuyWindow
  if times <= 0 then
    if isShowTips then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000076))
    end
    return false
  else
    if maxTime < times then
      if isShowTips then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000077))
      end
      return false
    else
      local itemId, Num = (AssetBuyWindow.GetConsumptionIdAndNum)(times)
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

AssetBuyWindow.GetConsumptionIdAndNum = function(times, ...)
  -- function num : 0_8 , upvalues : _ENV, assetID, AssetBuyWindow
  local alreadyTime = (AssetShopMgr.GetAssetBuyTimeByID)(assetID)
  local costNum = 0
  local getNum = 0
  local costID = 0
  local getID = 0
  local costType = nil
  for i = 1, times do
    local cost, reward = (AssetBuyWindow.GetSingleConsumeAndGet)(alreadyTime + i)
    local costStr = split(cost, ":")
    local getStr = split(reward, ":")
    costType = tonumber(costStr[1])
    costNum = costNum + costStr[3]
    getNum = getNum + getStr[3]
    costID = costStr[2]
    getID = getStr[2]
  end
  return tonumber(costID), costNum, tonumber(getID), getNum, costType
end

AssetBuyWindow.GetSingleConsumeAndGet = function(time, ...)
  -- function num : 0_9 , upvalues : _ENV, totalTime, buyType
  time = (math.min)(time, totalTime)
  local asset = (TableData.gTable).BaseBuyTimeData
  for _,v in pairs(asset) do
    if v.type == buyType and v.start <= time and time <= v.finish then
      return v.cost, v.reward
    end
  end
end

AssetBuyWindow.OnShown = function(...)
  -- function num : 0_10 , upvalues : uis, AssetBuyWindow, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ChangeNumberTxt).text = 1
  ;
  (AssetBuyWindow.SetConsumeAndGetShow)(tonumber((uis.ChangeNumberTxt).text))
end

AssetBuyWindow.OnHide = function(...)
  -- function num : 0_11
end

AssetBuyWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : uis, contentPane, argTable, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  if UIMgr:IsWindowOpen((WinResConfig.TaskWindow).name) and (TaskMgr.GetCurrentTaskType)() == TaskType.Daily then
    (TaskService.ReqTaskData)(TaskType.Daily, true)
  end
  if UIMgr:IsWindowOpen((WinResConfig.CardWindow).name) then
    UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_AFTERCLOSEGOLD, {})
  end
end

AssetBuyWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13
end

return AssetBuyWindow

