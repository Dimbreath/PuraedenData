-- params : ...
-- function num : 0 , upvalues : _ENV
require("Bag_SellWindowByName")
local BagSellAndBuyWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local itemID = 0
local BagSellType = {Sell = 1, Use = 2}
local winType = 0
local propID = 0
local itemData = nil
local maxAssetValue = 0
BagSellAndBuyWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, itemID, winType, propID, uis, BagSellAndBuyWindow, itemData, maxAssetValue, BagSellType
  bridgeObj:SetView((WinResConfig.BagSellAndBuyWindow).package, (WinResConfig.BagSellAndBuyWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  itemID = argTable[1]
  winType = argTable[2]
  propID = argTable[3]
  uis = GetBag_SellWindowUis(contentPane)
  uis = uis.SellGrp
  ;
  (BagSellAndBuyWindow.InitBasicInformation)()
  itemData = ((TableData.gTable).BasePropData)[itemID]
  local effect_value = split(itemData.effect_value, ":")
  maxAssetValue = (Util.GetMaxAssetNum)(tonumber(effect_value[1]))
  local goldConfig = ((TableData.gTable).BaseAssetData)[AssetType.GOLD]
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.OneLoader).url = (Util.GetItemUrl)(goldConfig.icon)
  ;
  (BagSellAndBuyWindow.InitBtn)()
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R3 in 'UnsetPending'

  if winType == BagSellType.Sell then
    (uis.c2Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.titilenameTxt).text = (PUtil.get)(20000363)
  else
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.c2Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.titilenameTxt).text = (PUtil.get)(20000362)
  end
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.HaveNumber_01_Txt).text = (PUtil.get)(20000348)
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
end

BagSellAndBuyWindow.InitBtn = function(...)
  -- function num : 0_1 , upvalues : uis, BagSellAndBuyWindow, _ENV, itemID, winType, BagSellType, propID
  ((uis.ReduceBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : BagSellAndBuyWindow
    (BagSellAndBuyWindow.AddNum)(-1)
  end
)
  ;
  ((uis.AddBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : BagSellAndBuyWindow
    (BagSellAndBuyWindow.AddNum)(1)
  end
)
  ;
  ((uis.Add10Btn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : BagSellAndBuyWindow
    (BagSellAndBuyWindow.AddNum)(10)
  end
)
  ;
  ((uis.MaxBtn).onClick):Set(function(...)
    -- function num : 0_1_3 , upvalues : _ENV, itemID, BagSellAndBuyWindow
    local totalNum = (ActorData.GetPropsByID)(itemID)
    ;
    (BagSellAndBuyWindow.AddNum)(totalNum, true)
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_4 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.BagSellAndBuyWindow).name)
  end
)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

  if winType == BagSellType.Sell then
    (uis.BuyBtn).text = (PUtil.get)(20000031)
  else
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.BuyBtn).text = (PUtil.get)(20000032)
  end
  ;
  ((uis.BuyBtn).onClick):Set(function(...)
    -- function num : 0_1_5 , upvalues : _ENV, uis, winType, BagSellType, propID, itemID
    local count = tonumber((uis.ChangeNumberTxt).text)
    if winType == BagSellType.Sell then
      (BagService.ReqSellProp)(propID, count)
      UIMgr:CloseWindow((WinResConfig.BagSellAndBuyWindow).name)
    else
      ;
      (BagService.UseProp)(itemID, propID, count)
      UIMgr:CloseWindow((WinResConfig.BagSellAndBuyWindow).name)
    end
  end
)
  ;
  (BagSellAndBuyWindow.RegisterLongPress)(uis.AddBtn, 1)
  ;
  (BagSellAndBuyWindow.RegisterLongPress)(uis.ReduceBtn, -1)
  ;
  (BagSellAndBuyWindow.RegisterLongPress)(uis.Add10Btn, 10)
end

BagSellAndBuyWindow.RegisterLongPress = function(btn, num, ...)
  -- function num : 0_2 , upvalues : _ENV, BagSellAndBuyWindow
  local LongPressAdd = (FairyGUI.LongPressGesture)(btn)
  LongPressAdd.once = false
  LongPressAdd.trigger = 0.2
  LongPressAdd.interval = 0.1
  local speed = 1
  local timer = nil
  ;
  (LongPressAdd.onBegin):Set(function(...)
    -- function num : 0_2_0 , upvalues : speed
    speed = 1
  end
)
  ;
  (LongPressAdd.onAction):Set(function(...)
    -- function num : 0_2_1 , upvalues : speed, _ENV, timer, LongPressAdd, BagSellAndBuyWindow, num
    speed = speed * 1.05
    local time = (Umath.Clamp)((math.floor)(speed), 1, 75)
    timer = (SimpleTimer.setInterval)(LongPressAdd.interval / time, time, function(...)
      -- function num : 0_2_1_0 , upvalues : BagSellAndBuyWindow, num
      (BagSellAndBuyWindow.AddNum)(num)
    end
)
  end
)
  ;
  (LongPressAdd.onEnd):Set(function(...)
    -- function num : 0_2_2 , upvalues : timer
    if timer then
      timer:stop()
    end
  end
)
end

BagSellAndBuyWindow.AddNum = function(num, noTip, ...)
  -- function num : 0_3 , upvalues : _ENV, uis, itemID, winType, BagSellType, itemData, maxAssetValue, BagSellAndBuyWindow
  local formerNum = tonumber((uis.ChangeNumberTxt).text)
  local afterNum = formerNum + num
  local totalNum = (ActorData.GetPropsByID)(itemID)
  if winType == BagSellType.Use and itemData.type == PropItemType.GIFT then
    totalNum = (math.min)(totalNum, 3000)
  end
  local afterNum = (Umath.Clamp)(afterNum, 1, totalNum)
  if winType == BagSellType.Use and itemData.type == PropItemType.ASSET_ITEM then
    local effect_value = split(itemData.effect_value, ":")
    local effectID = tonumber(effect_value[1])
    local effectValue = tonumber(effect_value[2])
    if maxAssetValue < effectValue * afterNum + (ActorData.GetAssetCount)(effectID) then
      local maxNum = (maxAssetValue - (ActorData.GetAssetCount)(effectID)) / effectValue
      -- DECOMPILER ERROR at PC74: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (uis.ChangeNumberTxt).text = (math.max)((math.floor)(maxNum), 1)
      if not noTip then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000184))
      end
      return 
    end
  else
    do
      -- DECOMPILER ERROR at PC114: Confused about usage of register: R6 in 'UnsetPending'

      if winType == BagSellType.Use and itemData.type == PropItemType.GIFT and (Util.GetGiftIsContainEquip)(itemID) and (Util.GetEquipRemainSlot)() < afterNum then
        (uis.ChangeNumberTxt).text = (math.max)((Util.GetEquipRemainSlot)(), 1)
        if not noTip then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000185))
        end
        return 
      end
      -- DECOMPILER ERROR at PC130: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (uis.ChangeNumberTxt).text = (math.ceil)(afterNum)
      ;
      (BagSellAndBuyWindow.SetSellPrice)()
    end
  end
end

BagSellAndBuyWindow.SetSellPrice = function(...)
  -- function num : 0_4 , upvalues : winType, BagSellType, _ENV, uis, itemID
  if winType == BagSellType.Sell then
    local Num = tonumber((uis.ChangeNumberTxt).text)
    local config = ((TableData.gTable).BasePropData)[itemID]
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.OneTxt).text = (math.ceil)(config.sell_price * Num)
  end
end

BagSellAndBuyWindow.InitBasicInformation = function(...)
  -- function num : 0_5 , upvalues : _ENV, itemID, uis
  local itemData, type = (Util.GetConfigDataByID)(itemID)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.ItemLoader).url = (Util.GetItemUrl)(itemData.icon)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.ItemNameTxt).text = itemData.name
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.HaveNumberTxt).text = (ActorData.GetPropsByID)(itemData.id)
  local DesText = uis.ItemWordTxt
  DesText.UBBEnabled = true
  DesText.text = itemData.remark
end

BagSellAndBuyWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : uis, BagSellAndBuyWindow
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ChangeNumberTxt).text = 1
  ;
  (BagSellAndBuyWindow.SetSellPrice)()
end

BagSellAndBuyWindow.OnHide = function(...)
  -- function num : 0_7
end

BagSellAndBuyWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

BagSellAndBuyWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9
end

return BagSellAndBuyWindow

